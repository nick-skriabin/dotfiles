return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local color = require("nskriabin.core.util.color").current()
        print(dump(color))
        require("tiny-glimmer").setup({
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
