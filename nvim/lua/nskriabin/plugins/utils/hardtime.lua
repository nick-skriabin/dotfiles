return {
    "m4xshen/hardtime.nvim",
    event = "BufEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
        restricted_keys = {
            ["j"] = { "n", "x", max_count = 4 },
            ["k"] = { "n", "x", max_count = 4 },
            ["l"] = { "n", "x", max_count = 5 },
            ["h"] = { "n", "x", max_count = 5 },
        },
        disabled_filetypes = {
            "qf",
            "netrw",
            "trouble",
            "lazy",
            "mason",
            "oil",
            "NeogitStatus",
            "dap-repl",
            "dapui_watches",
            "dapui_stacks",
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_frames",
            "neotest-summary",
        },
    },
}
