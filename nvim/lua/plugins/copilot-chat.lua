return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        dependencies = {
            { "github/copilot.vim" },
            { 'nvim-telescope/telescope-ui-select.nvim' }
        },
        opts = {
            prompts = {
                BetterNamings = "Please provide better names for the following variables and functions.", -- Prompt to suggest better names
                Concise = "Please rewrite the following text to make it more concise.",                   -- Prompt to make text concise
                Documentation = "Please provide documentation for the following code.",                   -- Prompt to generate documentation
                DocumentationForGithub =
                "Please provide documentation for the following code ready for GitHub using markdown.",   -- Prompt to generate GitHub documentation
                Explain = "Please explain how the following code works.",                                 -- Prompt to explain code
                FixCode = "Please fix the following code to make it work as intended.",                   -- Prompt to fix code
                FixError = "Please explain the error in the following text and provide a solution.",      -- Prompt to fix errors
                JsDocs = "Please provide JsDocs for the following code.",                                 -- Prompt to generate JsDocs
                Refactor = "Please refactor the following code to improve its clarity and readability.",  -- Prompt to refactor code
                Review = "Please review the following code and provide suggestions for improvement.",     -- Prompt to review code
                Summarize = "Please summarize the following text.",                                       -- Prompt to summarize text
                Tests = "Please explain how the selected code works, then generate unit tests for it.",   -- Prompt to generate unit tests
                Wording = "Please improve the grammar and wording of the following text.",                -- Prompt to improve wording

            },
            model = "gemini-2.5-pro",
            system_prompt =
            [[You are an expert programming assistant helping a developer named Javier. Always reply in English unless explicitly asked to use another language.\nJavier is an experienced software engineer working primarily with:\n- Vue.js (assume Vue 3 with <script setup lang="ts"> and the Composition API)\n- TypeScript and JavaScript\n- Go (Gin, GORM)\n- Neovim (with Lua configuration)\n- Pinia, Vue Query, Tailwind CSS, PrimeVue\n- Docker, Railway deployment, REST APIs\n- Testing (e.g., Playwright, Go testing)\n- Axios with well-typed requests/responses\n- Git, CI, and modern development workflows\nBehavior guidelines:\n- Be precise, direct, and based on current best practices and documentation.\n- Do not use emotionally charged or overly enthusiastic language.\n- Provide concrete, working code examples.\n- Avoid suggesting use of any in TypeScript.\n- When unsure, ask for clarification instead of guessing.\nUnless Javier states otherwise:\n- For Vue questions, assume Composition API and latest version.\n- For Neovim, assume Lua-based configuration.\n- For API typing, assume a preference for clarity and correctness over conciseness.\nUse a professional tone and aim for technically accurate and efficient answers.\nAlways provide code examples when relevant, and ensure they are well-typed and follow best practices.]],
            window = {
                layout = "vertical",
            },
        },
    },
}
