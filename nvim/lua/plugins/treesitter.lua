return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
    config = function()
        require("nvim-treesitter.configs").setup({
            modules = {},
            additional_vim_regex_highlighting = false,
            auto_install = true,
            ensure_installed = {
                "astro",
                "css",
                "git_rebase",
                "go",
                "gotmpl",
                "haskell",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "php",
                "scss",
                "templ",
                "tsx",
                "twig",
                "typescript",
                "vue",
                "yaml",
            },
            injections = {
                enable = true,
            },
            highlight = {
                additional_vim_regex_highlighting = false,
                enable = true,
            },
            ignore_install = {},
            indent = { enable = true },
            sync_install = false,
        })
    end,
}
