local M = {
    ["catppuccin-mocha"] = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        return {
            background = colors.surface0,
            base = colors.base,
            text = colors.text,
            highlight = colors.surface1,
            warn = colors.peach,
            textDimmed = colors.subtext0,
            border = colors.surface0,
        }
    end,
    ["zenbones"] = function(hello)
        local colors = require("zenbones.palette").dark
        return {
            border = colors.bg_stark.hex,
            background = colors.bg_stark.hex,
            base = colors.bg.hex,
            text = colors.fg.hex,
            highlight = colors.blossom1.darken(80).hex,
            warn = colors.wood1.hex,
            textDimmed = colors.water.hex,
        }
    end,
    ---@class LacklusterColor
    test = {
        lack = "#708090",
        luster = "#deeeed",
        orange = "#ffaa88",
        yellow = "#abab77",
        green = "#789978",
        blue = "#7788AA",
        red = "#D70000",
        none = "none",

        black = "#000000",
        gray1 = "#080808",
        gray2 = "#191919",
        gray3 = "#2a2a2a",
        gray4 = "#444444",
        gray5 = "#555555",
        gray6 = "#7a7a7a",
        gray7 = "#aaaaaa",
        gray8 = "#cccccc",
        gray9 = "#DDDDDD",
    },
    ["lackluster"] = function(hello)
        local colors = require("lackluster.color")
        return {
            border = colors.gray2,
            background = colors.gray2,
            base = colors.gray2,
            text = colors.gray6,
            highlight = colors.gray4,
            warn = colors.orange,
            textDimmed = colors.gray4,
        }
    end,
}

function M.current()
    return M[vim.g.colors_name]()
end

return M
