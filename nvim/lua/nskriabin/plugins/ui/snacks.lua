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
        {
            "<leader>bd",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>bD",
            function()
                Snacks.bufdelete.all()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame",
        },
        {
            "<leader>nh",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Show Notification History",
        },
        {
            "<leader>nu",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Dismiss Notifications",
        },
    },
    config = function()
        local Snacks = require("snacks")

        Snacks.setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            notifier = { enabled = true },
            lazygit = { enabled = true },
            terminal = { enabled = true },
            git = { enabled = true },
            rename = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    {
                        section = "header",
                    },
                    {
                        section = "keys",
                        gap = 1,
                        padding = 1,
                    },
                    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        section = "terminal",
                        cmd = "CACHE=3 ascii-image-converter ~/.config/nvim/assets/whaledev.png -C -c",
                        random = 10,
                        height = 30,
                        indent = 4,
                    },
                    { section = "startup" },
                },
            },
            quickfile = { enabled = true },
            statuscolumn = {
                enabled = true,
                left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                right = { "fold", "git" }, -- priority of signs on the right (high to low)
                folds = {
                    open = false, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { "GitSign", "MiniDiffSign" },
                },
                refresh = 50, -- refresh at most every 50ms
            },
            words = { enabled = false },
        })
    end,
}
