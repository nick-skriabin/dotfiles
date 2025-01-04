return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    event = "VeryLazy",
    keys = {
        { "<leader>st", ":TodoFzfLua<CR>", silent = true, desc = "Search Todos [cwd]" },
        { "<leader>xt", ":TodoTrouble<CR>", silent = true, desc = "Todos [Trouble, cwd]" },
    },
    config = true,
}
