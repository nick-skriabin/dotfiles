return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    keys = {
        { "<leader>gs", ":Neogit kind='auto'", desc = "Open neogit" },
        { "<leader>gc", ":Neogit commit kind='auto'", desc = "Open neogit" },
    },
}
