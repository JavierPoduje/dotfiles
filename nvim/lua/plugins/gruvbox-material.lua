return {

	"sainnhe/gruvbox-material",
	config = function()
		vim.g.gruvbox_material_palette = "material" -- 'material' | 'mix' | 'original'

		vim.g.gruvbox_material_background = "hard" -- 'hard' | 'medium' (default) | 'soft'

		-- Set transparent background
		vim.g.gruvbox_material_transparent_background = 0
		vim.g.gruvbox_material_enable_bold = 1

		--vim.cmd.colorscheme("gruvbox-material")
	end,
}
