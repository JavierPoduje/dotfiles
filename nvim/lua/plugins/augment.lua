return {
    "augmentcode/augment.vim",
    enabled = false,
    config = function()
        vim.g.augment_workspace_folders = {
            '~/.config',
            '~/Documents/projects/neovim/smartsort.nvim',
            '~/Documents/projects/personal-website',
        }
    end,
}
