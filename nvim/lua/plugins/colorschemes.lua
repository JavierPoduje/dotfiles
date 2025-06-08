return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            local flavour = "mocha" -- macchiato, mocha, frappe, latte
            local colors = require("catppuccin.palettes").get_palette(flavour)

            require("catppuccin").setup({
                flavour = flavour,
                styles = { comments = { "italic" }, conditionals = { "italic" } },
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                },
                transparent_background = true,
                custom_highlights = {
                    Comment = { fg = colors.overlay1 },
                    TreesitterContextLineNumber = { fg = colors.sky },
                    LineNr = { fg = colors.overlay0 },
                    CursorLineNr = { fg = colors.sky, style = { "bold" } },
                },
            })

            -- TODO: investigate what's the right place for setting the colorscheme
            if vim.g.colorscheme == "catppuccin" then
                vim.cmd("colorscheme catppuccin")
            end
        end,
    },
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_background = "hard"  -- 'hard' | 'medium' (default) | 'soft'
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_palette = "mix" -- 'material' | 'mix' | 'original'
            vim.g.gruvbox_material_transparent_background = 1

            if vim.g.colorscheme == "gruvbox-material" then
                vim.cmd.colorscheme("gruvbox-material")
            end
        end,
    },
    {
        "ayu-theme/ayu-vim",
        config = function()
            vim.g.ayucolor = "mirage" -- "light" | "mirage" | "dark"
            if vim.g.colorscheme == "ayu" then
                vim.cmd("colorscheme ayu")
            end
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        config = function()
            if vim.g.colorscheme == "kanagawa" then
                vim.cmd("colorscheme kanagawa-dragon")
                -- vim.cmd("colorscheme kanagawa-lotus")
                -- vim.cmd("colorscheme kanagawa-wave")
            end
        end,
    },
}
