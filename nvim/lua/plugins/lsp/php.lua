return {
    flags = { debounce_text_changes = 150, exit_timeout = 5000 },
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    root_dir = require("lspconfig").util.root_pattern("composer.json", ".git", "*.php"),
}
