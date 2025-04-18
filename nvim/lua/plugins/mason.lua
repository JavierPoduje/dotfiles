return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            lspconfig = {
                lua = "lua",
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = { "ts_ls", "eslint", "html", "cssls", "vimls" },
        })
    end,
}
