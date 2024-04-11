return {
    "declancm/maximize.nvim",
    config = function()
        require("maximize").setup()
    end,
    keys = {
        {
            "<leader>wm",
            function()
                require("maximize").toggle()
            end,
            desc = "Maximize",
        },
    },
}
