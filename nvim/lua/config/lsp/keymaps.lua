local lspconfig = require("lspconfig")
local cmp = require("cmp_nvim_lsp")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>gq", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>gf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- iterate over the lsp protocols attaching the commands and the completions
for _, protocol in ipairs({
	"cssls",
	"eslint",
	"golangci_lint_ls",
	"gopls",
	"intelephense",
	"lua_ls",
	"prismals",
	"tailwindcss",
	"tsserver",
	"vimls",
	"volar",
}) do
	if protocol == "cssls" then
		lspconfig[protocol].setup({
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
			capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})
	elseif protocol == "lua_ls" then
		lspconfig[protocol].setup({
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
			capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			settings = {
				Lua = {
					runtime = {
						version = "Lua 5.1",
					},
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	elseif protocol == "eslint" then
		lspconfig[protocol].setup({
			settings = {
				experimental = {
					-- check this later. there's probably a better way of handle this
					useFlatConfig = false,
				},
			},
		})
	else
		lspconfig[protocol].setup({
			on_attach = on_attach,
			flags = { debounce_text_changes = 150 },
			capabilities = cmp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		})
	end
end
