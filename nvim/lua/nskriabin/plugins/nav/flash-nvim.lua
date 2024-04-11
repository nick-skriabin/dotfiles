return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        search = {
            exclude = {
                "notify",
                "cmp_menu",
                "noice",
                "flash_prompt",
                "neo_tree",
                function(win)
                    -- exclude non-focusable windows
                    return not vim.api.nvim_win_get_config(win).focusable
                end,
            },
        },
        modes = {
            search = {
                enabled = false,
            },
        },
    },
    keys = {
        {
            "s",
            mode = { "n" },
            function()
                require("flash").jump()
            end,
            desc = "Flash",
        },
        {
            "S",
            mode = { "n" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "<c-q>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
