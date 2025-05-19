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

        local lspconfig = require("lspconfig")
        local cmp = require("cmp_nvim_lsp")

        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
            vim.keymap.set("n", "<leader>gf", function()
                vim.lsp.buf.format({ async = true })
            end, bufopts)
        end

        -- iterate over the lsp protocols attaching the commands and the completions
        for _, protocol in ipairs({
            "astro",
            "biome",
            "cssls",
            "eslint",
            "golangci_lint_ls",
            "gopls",
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
                -- elseif protocol == "eslint" then
                --     lspconfig[protocol].setup({
                --         settings = {
                --             experimental = {
                --                 -- check this later. there's probably a better way of handle this
                --                 useFlatConfig = false,
                --             },
                --         },
                --     })
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
