return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufEnter" },
    keys = {
        {
            "<leader>st",
            function()
                Snacks.picker.todo_comments()
            end,
            silent = true,
            desc = "Search Todos [cwd]",
        },
        { "<leader>xt", ":TodoTrouble<CR>", silent = true, desc = "Todos [Trouble, cwd]" },
    },
    config = true,
}
