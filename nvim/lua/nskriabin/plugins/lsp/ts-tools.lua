return {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
        settings = {
            expose_as_code_action = { "add_missing_imports", "organize_imports" },
            tsserver_plugins = { "typescript-plugin-css-modules" },
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeCompletionsForModuleExports = true,
            },
        },
    },
}
