local init_highlights = require("nskriabin.core.ui.init_highlights")
return {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,

    opts = {
        transparent_background = true,
    },
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
    --
    config = function()
        require("zenbones")
        -- vim.cmd([[colorscheme catppuccin]])
        vim.g.zenbones_transparent_background = true
        vim.g.zenbones_darkness = "stark"
        vim.cmd([[colorscheme zenbones]])

        init_highlights("zenbones")
    end,
}
