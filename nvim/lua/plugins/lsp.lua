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

        -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { noremap = true, silent = true })
        -- vim.keymap.set("n", "K", function()
        --     return vim.lsp.buf.hover({ border = "rounded" })
        -- end, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { noremap = true, silent = true })
        -- vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.format({ async = true }) end,
        --     { noremap = true, silent = true })

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
            "basedpyright",
            "vimls",
        }) do
            if protocol == "cssls" then
                local cssconfig = require("plugins/lsp/css")
                vim.lsp.config.css = cssconfig
                vim.lsp.config.scss = cssconfig
            elseif protocol == "intelephense" then
                vim.lsp.config.php = require("plugins/lsp/php")
            elseif protocol == "basedpyright" then
                local pythonconfig = require("plugins/lsp/python")
                vim.lsp.config.python = pythonconfig
                vim.lsp.config.py = pythonconfig
            elseif protocol == "vtsls" then
                vim.lsp.config.vue = require("plugins/lsp/vue")
            elseif protocol == "gopls" then
                vim.lsp.config.go = require("plugins/lsp/go")
            else
                vim.lsp.config("*", {
                    flags = { debounce_text_changes = 150 },
                    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol
                        .make_client_capabilities()),
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
            "basedpyright",
            "vimls",
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
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
            end,
        })
    end,
}
