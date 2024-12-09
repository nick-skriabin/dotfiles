return {
    "folke/zen-mode.nvim",
    keys = {
        { "<leader>zz", ":ZenMode<cr>", silent = true, desc = "Toggle Zen Mode" },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
            width = 120,
        },
        plugins = {
            kitty = { enabled = true, font = "+6" },
            tmux = { enabled = true },
        },
        on_open = function()
            require("lualine").hide()
        end,
        on_close = function()
            require("lualine").hide({ unhide = true })
        end,
    },
}
