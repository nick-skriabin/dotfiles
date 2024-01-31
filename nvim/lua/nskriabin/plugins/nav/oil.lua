return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    opts = {
        skip_confirm_for_simple_edits = true,
        win_options = {
            signcolumn = "yes:2",
        },
    },
    keys = {
        { "-", ":lua require('oil').open()<cr>", desc = "Open parent dir", silent = true },
    },
}
