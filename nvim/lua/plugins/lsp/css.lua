return {
    flags = { debounce_text_changes = 150, exit_timeout = 5000 },
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = { "css", "scss", "less" },
    settings = {
        css = {
            lint = {
                unknownAtRules = "ignore",
            },
        },
    },
}
