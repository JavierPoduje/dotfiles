return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	dependencies = { "honza/vim-snippets" },
	config = function()
		local ls = require("luasnip")

		vim.keymap.set({ "i" }, "<C-K>", function()
			ls.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-b>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-x>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		require("luasnip.loaders.from_snipmate").lazy_load()
		require("luasnip.loaders.from_snipmate").lazy_load({ path = "./snippets" })
	end,
}
