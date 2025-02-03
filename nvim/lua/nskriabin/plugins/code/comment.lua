return {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            lazy = false,
            priority = 100,
            config = function()
                require("ts_context_commentstring").setup({})
            end,
        },
    },
    lazy = false,
    config = function()
        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
