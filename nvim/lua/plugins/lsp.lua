return {
    "neovim/nvim-lspconfig",
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
        { "<C-k>",     vim.diagnostic.open_float, silent = true },
        { "<leader>[", vim.diagnostic.goto_prev,  silent = true },
        { "<leader>]", vim.diagnostic.goto_next,  silent = true },
        { "<space>gq", vim.diagnostic.setloclist, silent = true },
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                --source = "always",
                header = "",
                prefix = "",
            },
        })

        local lspconfig = require("lspconfig")
        local cmp = require("cmp_nvim_lsp")

        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
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
            "biome",
            "cssls",
            "eslint",
            "golangci_lint_ls",
            "gopls",
            "intelephense",
            "lua_ls",
            "prismals",
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
            elseif protocol == "eslint" then
                lspconfig[protocol].setup({
                    settings = {
                        experimental = {
                            -- check this later. there's probably a better way of handle this
                            useFlatConfig = false,
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

        -- UI
        vim.fn.sign_define("DiagnosticSignError",
            { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn",
            { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignHint",
            { text = "", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
        vim.fn.sign_define("DiagnosticSignInfo",
            { text = "", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

        vim.api.nvim_create_autocmd('LspAttach', {
            pattern = { "*.lua" },
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end

                if client.supports_method("textDocument/formatting") then
                    -- format the current buffer on save
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end
                    })
                end
            end
        })
    end,
}
