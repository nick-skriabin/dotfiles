return {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufEnter" },
    config = function()
        require("treesitter-context").setup({
            multiline_threshold = 5, -- Maximum number of lines to show for a single context
        })
    end,
}
