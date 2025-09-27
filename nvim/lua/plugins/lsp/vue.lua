local vue_language_server_path = '/Users/puje/.config/nvim/node_modules/@vue/language-server'
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
}
return {
    flags = { debounce_text_changes = 150 },
    capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            experimental = {
                maxInlayHintLength = 30,
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
            tsserver = {
                -- Add plugins in corresponding files
                globalPlugins = { vue_plugin },
            },
        },
        javascript = {
            updateImportsOnFileMove = "always",
        },
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
            preferences = {
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifier = "non-relative",
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
