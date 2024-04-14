local null_ls = require("null-ls")

-- Initialize null_ls setup
local sources = {}

-- Only use `eslint` if the project isn't a Deno one
if
	vim.fn.filereadable(vim.fn.getcwd() .. "/.eslintrc") == 1
	or vim.fn.filereadable(vim.fn.getcwd() .. "./.eslintrc.js")
	or vim.fn.filereadable(vim.fn.getcwd() .. "./.eslintrc.cjs")
then
	table.insert(sources, null_ls.builtins.diagnostics.eslint)
end

--null_ls.setup({
--  sources = sources,
--})
