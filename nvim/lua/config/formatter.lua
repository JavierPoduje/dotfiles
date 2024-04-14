local current_file = vim.api.nvim_buf_get_name(0)

local formatter = function(formatter, args, stdin)
	return function()
		return {
			exe = formatter,
			args = args,
			stdin = stdin,
		}
	end
end

-- Args definitions
local prettier_args = function(parser)
	return {
		"--write",
		current_file,
		"--parser",
		parser,
	}
end

local vue_args = {
	"--write",
	current_file,
	"--single-quote",
	"--single-attribute-per-line",
	"--bracket-same-line",
	"--parser",
	"vue",
}

local php_args = {
	"--single-quote",
	"--stdin-filepath",
	current_file,
	"--print-width",
	80,
	"--parser",
	"php",
	"--php-version",
	"7.1",
	"--tab-width",
	4,
}

local sql_args = {
	"--config",
	"~/.config/nvim/sql-formatter.json",
	current_file,
}

local lua_args = {
	"--column-width",
	120,
	"--line-endings",
	"Unix",
	"--indent-type",
	"Tabs",
	"--indent-width",
	2,
	"--quote-style",
	"AutoPreferDouble",
}

local rust_args = {
	"--emit=stdout",
	"--edition=2021",
}

local python_args = {
	"%",
}

local prisma_args = {
	"prisma",
	"format",
	"--schema=" .. current_file,
}

-- Actual formatter definition
require("formatter").setup({
	logging = false,
	filetype = {
		elixir = { formatter("mix format", { current_file }, false) },
		graphql = { formatter("prettier", prettier_args("graphql"), true) },
		html = { formatter("prettier", prettier_args("html"), false) },
		javascript = { formatter("prettier", prettier_args("typescript"), false) },
		javascriptreact = { formatter("prettier", prettier_args("typescript"), false) },
		json = { formatter("prettier", prettier_args("json"), true) },
		vue = { formatter("prettier", vue_args, true) },
		lua = { formatter("stylua", lua_args, false) },
		php = { formatter("prettier", php_args, true) },
		prisma = { formatter("npx", prisma_args, false) },
		rust = { formatter("rustfmt", rust_args, true) },
		scss = { formatter("prettier", prettier_args("scss"), true) },
		css = { formatter("prettier", prettier_args("css"), true) },
		sql = { formatter("sql-formatter", sql_args, true) },
		typescript = { formatter("prettier", prettier_args("typescript"), false) },
		typescriptreact = { formatter("prettier", prettier_args("typescript"), false) },
		python = { formatter("!black", python_args, true) },
	},
})

-- TODO: all formats should use the same command, the file type shouldn't matter...
-- format `deno` files
vim.keymap.set("n", "<Leader>fd", ":! deno fmt % -q<CR>", { silent = true })

-- format every other file
vim.keymap.set("n", "<leader>ff", ":Format<CR>", { silent = true })
