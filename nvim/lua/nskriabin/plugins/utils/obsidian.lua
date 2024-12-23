return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cmd = { "ObsidianToday", "ObsidianSearch", "ObsidianToggleCheckbox", "ObsidianNew" },
    keys = {
        { "<M-o>d", ":ObsidianToday<cr>", desc = "Create daily note" },
        { "<M-o>o", ":ObsidianSearch<cr>", desc = "Search notes" },
        { "<M-o>t", ":ObsidianToggleCheckbox<cr>", desc = "Toggle checkbox" },
        { "<M-o>n", ":ObsidianNew ", desc = "Toggle checkbox" },
    },
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre path/to/my-vault/*.md",
        "BufNewFile path/to/my-vault/*.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        ui = { enable = false },
        workspaces = {
            {
                name = "whaledev",
                path = "~/Git/vaults/whaledev/Whaledev/",
            },
        },

        -- see below for full list of options 👇
    },
    templates = {
        folder = "~/Git/vaults/whaledev/templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
    },
}
