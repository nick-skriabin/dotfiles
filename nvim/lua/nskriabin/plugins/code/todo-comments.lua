return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    keys = {
        { "<leader>st", ":TodoTelescope<CR>", silent = true, desc = "Search Todos [cwd]" },
        { "<leader>xt", ":TodoTrouble<CR>", silent = true, desc = "Todos [Trouble, cwd]" },
    },
    opts = {
        -- TODO: add configuration here
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
}
