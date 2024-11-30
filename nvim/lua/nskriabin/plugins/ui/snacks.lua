return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
    },
    config = function()
        local Snacks = require("snacks")

        Snacks.setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            notifier = { enabled = false },
            lazygit = { enabled = true },
            terminal = { enabled = true },
            git = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    -- {
                    --     pane = 2,
                    --     section = "terminal",
                    --     cmd = "colorscript -e square",
                    --     height = 5,
                    --     padding = 1,
                    -- },
                    { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    -- {
                    --     pane = 2,
                    --     icon = " ",
                    --     title = "Git Status",
                    --     section = "terminal",
                    --     enabled = Snacks.git.get_root() ~= nil,
                    --     cmd = "hub status --short --branch --renames",
                    --     height = 5,
                    --     padding = 1,
                    --     ttl = 5 * 60,
                    --     indent = 3,
                    -- },
                    { section = "startup" },
                },
            },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = false },
        })
    end,
}
