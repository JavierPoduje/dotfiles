return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
        -- add any options here
    },
    config = function()
        require('Comment').setup()
    end
}
