return {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
        require("marks").setup({
            default_mappings = true,
            mappings = {
                toggle = "mt",
                next = "mm",
                prev = "mp",
                delete_buf = "dm<space>",
                delete_line = "dm-",
            },
        })
    end,
}
