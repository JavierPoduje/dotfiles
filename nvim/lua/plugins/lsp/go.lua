return {
    flags = { debounce_text_changes = 150, exit_timeout = 5000 },
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    filetypes = { "go", "gomod", "gotmpl" },
    root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },

}
