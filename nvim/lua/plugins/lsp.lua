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

        vim.lsp.config("lua_ls", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }, -- recognize vim as a global variable
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- include runtime files in the workspace
                    },
                },
            },
        })
        vim.lsp.config("ts_ls", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
                ts_ls = {
                    completions = {
                        completeFunctionCalls = true,
                    },
                    format = {
                        enable = true,
                    },
                },
            },
        })
        vim.lsp.config("cssls", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
                css = {
                    validate = true,
                },
                scss = {
                    validate = true,
                },
                less = {
                    validate = true,
                },
            },
        })

        vim.lsp.config("gopls", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
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

        vim.lsp.config("intelephense", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            root_dir = lspconfig.util.root_pattern("composer.json", ".git", "*.php"),
        })

        vim.lsp.config('vtsls', {
            settings = {
                vtsls = {
                    tsserver = {
                        globalPlugins = {
                            name = '@vue/typescript-plugin',
                            location = '/Users/puje/.nvm/versions/node/v22.14.0/lib/node_modules/@vue/language-server',
                            languages = { 'vue' },
                            configNamespace = 'typescript',
                        },
                    },
                },
            },
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        })

        vim.lsp.config("*", {
            flags = { debounce_text_changes = 150 },
            capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        })

        vim.lsp.enable({
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
            "vtsls",
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
        vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.format({ async = true }) end)

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
