return {
	"javierpoduje/taboo",
	--dev = true,
	config = function()
		require("taboo")
		vim.keymap.set("n", "<Leader>tt", ":TabooOpen<CR>", { silent = true })
	end,
}
