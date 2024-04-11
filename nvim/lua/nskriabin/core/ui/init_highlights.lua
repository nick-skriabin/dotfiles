local themes = require("nskriabin.core.util.color")
local function theme(theme_name)
    return themes[theme_name]()
end

local function init_colors()
    local hl = vim.api.nvim_set_hl
    local colors = themes.current()
    local bg = colors.base
    local fg = colors.text

    -- Noice
    hl(0, "NoiceCmdlinePopup", { bg = bg })

    -- Telescope
    hl(0, "TelescopeNormal", { bg = bg, fg = fg })
    hl(0, "TelescopeBorder", { bg = bg, fg = bg })
    hl(0, "TelescopePromptBorder", { bg = bg, fg = bg })

    -- CMP
    hl(0, "CmpNormal", { bg = bg })
    hl(0, "CmpNormalFloat", { bg = bg })

    -- Popup menu
    hl(0, "PmenuSel", { blend = 0 })
end

return init_colors
