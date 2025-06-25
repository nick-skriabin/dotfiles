local init_highlights = require("nskriabin.core.ui.init_highlights")
-- example lazy.nvim install setup
return {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        local lackluster = require("lackluster")

        lackluster.setup({
            tweak_syntax = {
                comment = lackluster.color.gray4, -- or gray5
            },
            tweak_background = {
                normal = "none",
                telescope = "none",
                menu = lackluster.color.gray3,
                popup = "default",
            },
        })

        vim.cmd.colorscheme("lackluster")
        init_highlights()
    end,
}
