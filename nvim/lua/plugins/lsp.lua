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

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
        vim.keymap.set("n", "K", function()
            return vim.lsp.buf.hover({ border = "rounded" })
        end, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.format({ async = true }) end,
            { noremap = true, silent = true })

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
            -- "volar",
            -- "vue_ls",
            -- "vtsls",
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
            elseif protocol == "vtsls" then
                local vue_language_server_path = '/Users/puje/.config/nvim/node_modules/@vue/language-server'
                local vue_plugin = {
                    name = '@vue/typescript-plugin',
                    location = vue_language_server_path,
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                }
                lspconfig[protocol].setup({
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 150 },
                    capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            experimental = {
                                maxInlayHintLength = 30,
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                            tsserver = {
                                -- Add plugins in corresponding files
                                globalPlugins = { vue_plugin },
                            },
                        },
                        javascript = {
                            updateImportsOnFileMove = "always",
                        },
                        typescript = {
                            updateImportsOnFileMove = { enabled = "always" },
                            suggest = {
                                completeFunctionCalls = true,
                            },
                            inlayHints = {
                                enumMemberValues = { enabled = true },
                                functionLikeReturnTypes = { enabled = true },
                                parameterNames = { enabled = "literals" },
                                parameterTypes = { enabled = true },
                                propertyDeclarationTypes = { enabled = true },
                                variableTypes = { enabled = false },
                            },
                            preferences = {
                                includeCompletionsForModuleExports = true,
                                includeCompletionsForImportStatements = true,
                                importModuleSpecifier = "non-relative",
                            },
                        },
                    },
                    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },

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
