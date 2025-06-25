return {
    { "JoosepAlviste/nvim-ts-context-commentstring", opts = { enable_autocmd = false } },
    {
        "echasnovski/mini.comment",
        version = "*",
        config = function()
            require("mini.comment").setup({
                options = {
                    custom_commentstring = function()
                        return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                    end,
                },
            })
        end,
    },
}
