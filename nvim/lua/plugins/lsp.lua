return {
	"neovim/nvim-lspconfig",
	keys = {
		{ "<C-k>", vim.diagnostic.open_float, silent = true },
		{ "<leader>[", vim.diagnostic.goto_prev, silent = true },
		{ "<leader>]", vim.diagnostic.goto_next, silent = true },
		{ "<space>gq", vim.diagnostic.setloclist, silent = true },
	},
	config = function()
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			underline = true,
			severity_sort = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local lspconfig = require("lspconfig")
		local cmp = require("cmp_nvim_lsp")

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

		-- UI
		local signs = { Error = "", Warn = "", Hint = "", Info = "" }

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	end,
}
