local themes = require("nskriabin.core.util.color")
local au = require("nskriabin.auto.utils")

local function init_colors()
    local hl = vim.api.nvim_set_hl
    local colors = themes.current()
    local bg = colors.base
    local fg = colors.text

    local default_bg_alone = { bg = colors.base }
    local default_bg = { bg = colors.base, fg = colors.base }
    local default_fg = { bg = colors.base, fg = colors.text }

    -- Noice
    hl(0, "NoiceCmdlinePopup", default_bg_alone)

    -- Telescope
    hl(0, "TelescopeNormal", default_fg)
    hl(0, "TelescopeBorder", default_bg)
    hl(0, "TelescopePromptBorder", default_bg)

    hl(0, "NormalFloat", default_fg)
    hl(0, "FloatBorder", default_bg)
    hl(0, "BlinkCmpMenuSelection", { bg = colors.highlight })

    -- CMP
    hl(0, "CmpNormal", default_bg_alone)
    hl(0, "CmpNormalFloat", default_bg_alone)

    -- Popup menu
    hl(0, "Pmenu", { blend = 0, bg = bg })
    hl(0, "PmenuSel", { blend = 0, bg = bg })

    au.cmd("FileType", {
        pattern = "mason",
        group = au.group("MasonHl"),
        callback = function()
            hl(0, "MasonNormal", default_bg_alone)
        end,
    })

    au.cmd("FileType", {
        pattern = "lazy",
        group = au.group("Lazy"),
        callback = function()
            hl(0, "LazyNormal", default_bg_alone)
        end,
    })
end

return init_colors
