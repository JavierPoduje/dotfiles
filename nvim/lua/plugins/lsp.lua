return {
    "neovim/nvim-lspconfig",
    -- TODO: for some reason, this is necessary for LSP to load in lua projects. investigate why
    lazy = false,
    dependencies = {
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    keys = {
        {
            "<C-k>",
            vim.diagnostic.open_float,
            silent = true,
        },
        {
            "<leader>[",
            function() vim.diagnostic.jump({ count = -1, float = true }) end,
            silent = true
        },
        {
            "<leader>]",
            function() vim.diagnostic.jump({ count = 1, float = true }) end,
            silent = true,
        },
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.HINT] = "",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                    [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                    [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
                },
            },
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
        })

        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            local set_keymap = function(key, action) vim.keymap.set("n", key, action, bufopts) end

            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
            set_keymap("<leader>gD", vim.lsp.buf.declaration)
            set_keymap("<leader>gD", vim.lsp.buf.declaration)
            set_keymap("K", vim.lsp.buf.hover)
            set_keymap("<leader>gi", vim.lsp.buf.implementation)
            set_keymap("<leader>D", vim.lsp.buf.type_definition)
            set_keymap("<leader>R", vim.lsp.buf.rename)
            set_keymap("<leader>ga", vim.lsp.buf.code_action)
            set_keymap("<leader>gr", vim.lsp.buf.references)
            set_keymap("<leader>gf", function() vim.lsp.buf.format({ async = true }) end)
        end

        -- iterate over the lsp protocols attaching the commands and the completions
        local lspconfig = require("lspconfig")
        local cmp = require("cmp_nvim_lsp")
        for _, protocol in ipairs({
            "astro",
            "biome",
            "cssls",
            "eslint",
            "gopls",
            "hls",
            "intelephense",
            "lua_ls",
            "tailwindcss",
            "ts_ls",
            "vimls",
            "volar",
        }) do
            if protocol == "cssls" then
                lspconfig[protocol].setup({
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                    filetypes = { "css", "scss", "less" },
                    settings = {
                        css = {
                            lint = {
                                unknownAtRules = "ignore",
                            },
                        },
                    },
                })
            elseif protocol == "intelephense" then
                lspconfig[protocol].setup({
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                    root_dir = lspconfig.util.root_pattern("composer.json", ".git", "*.php"),
                })
            elseif protocol == "gopls" then
                lspconfig[protocol].setup({
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                    filetypes = { "go", "gomod", "gotmpl" },
                    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            staticcheck = true,
                        },
                    },
                })
            else
                lspconfig[protocol].setup({
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                })
            end
        end

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.buf.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.buf.signature_help, { border = "rounded" })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { "lua" },
            callback = function(args)
                local format = function()
                    vim.lsp.buf.format({ bufnr = args.buf })
                end
                vim.keymap.set("n", "<leader>f", format, { buffer = 0 })
            end
        })
    end,
}
