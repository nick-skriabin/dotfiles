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
            { "<leader>b", group = "Buffers" },
            { "<leader>c", group = "Code Actions" },
            { "<leader>cp", group = "Packages" },
            { "<leader>d", group = "Debug" },
            { "<leader>f", group = "Files" },
            { "<leader>g", group = "Git(Hub)" },
            { "<leader>H", group = "Hunks", icon = "" },
            { "<leader>i", group = "DBUI" },
            { "<leader>k", group = "Kulala", icon = "󱂛" },
            { "<leader>l", group = "Managers", icon = "󰏓" },
            { "<leader>n", group = "Notifications", icon = "󱅫" },
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
                { "<leader>c", group = "Code Actions" },
                { "<leader>n", group = "Swap Next" },
                { "<leader>p", group = "Swap Previous" },
                { "<leader>s", group = "Search" },
            },

            { "<space>p", hidden = true },
            { "<space>n", hidden = true },
        })
    end,
}
