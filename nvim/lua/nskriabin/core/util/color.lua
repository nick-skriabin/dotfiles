local M = {
    ["catppuccin-mocha"] = function()
        local colors = require("catppuccin.palettes").get_palette("mocha")
        return {
            base = colors.base,
            text = colors.text,
            warn = colors.peach,
            textDimmed = colors.subtext0,
            border = colors.surface0,
        }
    end,
    ["kanagawa-dragon"] = function()
        local colors = require("kanagawa.colors").setup({ theme = "dragon" }).palette

        return {
            base = colors.dragonBlack0,
            text = colors.dragonGray2,
            warn = colors.dragonOrange2,
            textDimmed = colors.dragonBlack4,
            border = colors.dragonBlack4,
        }
    end,
}

function M.current()
    return M[vim.g.colors_name]()
end

return M
