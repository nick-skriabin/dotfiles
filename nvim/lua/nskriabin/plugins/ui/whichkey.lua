return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    dependencies = {
        { "echasnovski/mini.icons", version = false },
    },
    config = function()
        local wk = require("which-key")

        wk.setup({
            defaults = {},
            plugins = {
                marks = true,
                registers = true,
                spelling = {
                    enabled = true,
                    suggestions = 20,
                },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
        })

        wk.add({
            { "<leader>a", group = "Avante", icon = "" },
            { "<leader>b", group = "Buffers", icon = "" },
            { "<leader>c", group = "Code Actions", icon = "󰘦" },
            { "<leader>cp", group = "Packages", icon = " " },
            { "<leader>d", group = "Debug", icon = "" },
            { "<leader>f", group = "Files", icon = "" },
            { "<leader>g", group = "Git(Hub)", icon = "" },
            { "<leader>H", group = "Hunks", icon = "" },
            { "<leader>i", group = "Database", icon = "" },
            { "<leader>k", group = "Kulala", icon = "󱂛" },
            { "<leader>l", group = "Managers", icon = "󰏓" },
            { "<leader>n", group = "Notifications", icon = "󱅫" },
            { "<leader>m", group = "Markdown", icon = "" },
            { "<leader>o", group = "Octo", icon = "" },
            { "<leader>op", group = "Octo PR" },
            { "<leader>or", group = "Octo Review" },
            { "<leader>q", group = "Quit" },
            { "<leader>s", group = "Search" },
            { "<leader>t", group = "Tests" },
            { "<leader>u", group = "UI" },
            { "<leader>w", group = "Window" },
            { "<leader>x", group = "Diagnostics" },
            {
                mode = { "v" },
                { "<leader>a", group = "Avante" },
                { "<leader>b", group = "Buffers" },
                { "<leader>c", group = "Code Actions", icon = "󰘦" },
                { "<leader>n", group = "Swap Next" },
                { "<leader>p", group = "Swap Previous" },
                { "<leader>s", group = "Search" },
                { "<leader>s", group = "Markdown" },
            },

            { "<space>p", hidden = true },
            { "<space>n", hidden = true },
        })
    end,
}
