return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local color = require("nskriabin.core.util.color").current()
        require("tiny-glimmer").setup({
            overwrite = {
                auto_map = false,
            },
            animations = {
                fade = {
                    from_color = color.warn,
                    to_color = color.highlight,
                },
            },
            transparency_color = "#000000",
        })
    end,
}
