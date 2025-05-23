return {
    "mhinz/vim-startify",
    config = function()
        vim.g.startify_lists = {
            { type = "sessions", header = { "   Sessions:" } },
            { type = "dir", header = { "   Current Directory: " .. vim.fn.getcwd() } },
            { type = "bookmarks", header = { "  Bookmarks:" } },
        }

        vim.g.startify_session_persistence = 1
        vim.g.startify_change_to_vcs_root = 1
    end,
}
