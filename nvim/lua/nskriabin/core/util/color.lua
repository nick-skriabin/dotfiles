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
}

function M.current()
    return M[vim.g.colors_name]()
end

return M
