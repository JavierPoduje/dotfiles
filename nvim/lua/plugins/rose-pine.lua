return {
	"rose-pine/neovim",
	config = function()
		require("rose-pine").setup({
			variant = "moon", -- auto, main, moon, or dawn
			dark_variant = "moon", -- main, moon, or dawn
			styles = {
				bold = true,
				italic = true,
				transparency = false,
			},
		})
		--vim.cmd("colorscheme rose-pine-moon")
	end,
}
