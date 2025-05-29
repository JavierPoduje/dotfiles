return {
    "augmentcode/augment.vim",
    enabled = true,
    config = function()
        vim.g.augment_workspace_folders = {
            '~/.config',
            '~/Documents/projects/neovim/smartsort.nvim',
            '~/Documents/projects/personal-website',
        }
    end,
}
