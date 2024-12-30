return {
    "mhartington/formatter.nvim",
    config = function()
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

        local biome_args = function()
            return {
                "format",
                "--write",
                current_file,
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
            "--arrow-parens",
            "avoid",
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

        --local lua_args = {
        --    "--config-path",
        --    "nvim/stylua.toml",
        --}

        local rust_args = {
            "--emit=stdout",
            "--edition=2021",
        }

        local prisma_args = {
            "prisma",
            "format",
            "--schema=" .. current_file,
        }

        require("formatter").setup({
            logging = false,
            filetype = {
                css = { formatter("prettier", prettier_args("css"), true) },
                elixir = { formatter("mix format", { current_file }, false) },
                go = { formatter("golines", { "-w", current_file }, false) },
                graphql = { formatter("prettier", prettier_args("graphql"), true) },
                html = { formatter("prettier", prettier_args("html"), false) },
                javascript = { formatter("biome", biome_args(), false) },
                --javascript = { formatter("prettier", prettier_args("typescript"), false) },
                json = { formatter("prettier", prettier_args("json"), true) },
                --lua = { formatter("stylua", lua_args, false) },
                php = { formatter("prettier", php_args, true) },
                prisma = { formatter("npx", prisma_args, false) },
                rust = { formatter("rustfmt", rust_args, true) },
                scss = { formatter("prettier", prettier_args("scss"), true) },
                sql = { formatter("sql-formatter", sql_args, true) },
                typescript = { formatter("biome", biome_args(), false) },
                --typescript = { formatter("prettier", prettier_args("typescript"), false) },
                --typescriptreact = { formatter("biome", biome_args(), false) },
                vue = { formatter("prettier", vue_args, true) },
            },
        })

        -- format every other file
        vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
    end,
}
