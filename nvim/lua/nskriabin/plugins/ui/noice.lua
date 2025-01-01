return {
    "folke/noice.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        notify = { enabled = false },
        popupmenu = { enabled = false },
        lsp = { enabled = false },
        views = {
            cmdline_popup = {
                border = { style = "none", padding = { 1, 2 } },
                position = { row = 5, col = "50%" },
                size = { width = 60, height = "auto" },
            },
        },
    },
}
