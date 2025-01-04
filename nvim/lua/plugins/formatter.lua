return {
    "mhartington/formatter.nvim",
    config = function()
        local if_else = require("utils").if_else
        local current_file = vim.api.nvim_buf_get_name(0)
        local prioritze_biome_over_prettier = false

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

        local sql_args = {
            "--config",
            "~/.config/nvim/sql-formatter.json",
            current_file,
        }

        require("formatter").setup({
            logging = false,
            filetype = {
                css = { formatter("prettier", prettier_args("css"), true) },
                elixir = { formatter("mix format", { current_file }, false) },
                go = { formatter("golines", { "-w", current_file }, false) },
                html = { formatter("prettier", prettier_args("html"), false) },
                javascript = {
                    formatter(
                        if_else(prioritze_biome_over_prettier, "biome", "prettier"),
                        if_else(prioritze_biome_over_prettier, biome_args(), prettier_args("typescript")),
                        false
                    ) },
                json = { formatter("prettier", prettier_args("json"), true) },
                scss = { formatter("prettier", prettier_args("scss"), true) },
                sql = { formatter("sql-formatter", sql_args, true) },
                typescript = {
                    formatter(
                        if_else(prioritze_biome_over_prettier, "biome", "prettier"),
                        if_else(prioritze_biome_over_prettier, biome_args(), prettier_args("typescript")),
                        false
                    ) },
                vue = { formatter("prettier", vue_args, true) },
            },
        })

        -- format every other file
        vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
    end,
}
