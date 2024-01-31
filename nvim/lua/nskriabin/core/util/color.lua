local M = {
    catppuccin = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        return {
            base = colors.base,
            text = colors.text,
            warn = colors.peach,
            textDimmed = colors.subtext0,
        }
    end,
    kanagawa = function()
        local colors = require("kanagawa.colors").setup({ theme = "dragon" }).palette

        return {
            base = colors.dragonBlack0,
            text = colors.dragonGray2,
            warn = colors.dragonOrange2,
            textDimmed = colors.dragonBlack4,
        }
    end,
}

return M
