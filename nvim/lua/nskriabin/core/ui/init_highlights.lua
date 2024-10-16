local themes = require("nskriabin.core.util.color")
local au = require("nskriabin.auto.utils")

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
    hl(0, "BlinkCmpMenuSelection", { bg = colors.highlight })

    -- Popup menu
    hl(0, "PmenuSel", { blend = 0 })

    au.cmd("FileType", {
        pattern = "mason",
        group = au.group("MasonHl"),
        callback = function()
            hl(0, "MasonNormal", { bg = bg })
        end,
    })

    au.cmd("FileType", {
        pattern = "lazy",
        group = au.group("Lazy"),
        callback = function()
            hl(0, "LazyNormal", { bg = bg })
        end,
    })
end

return init_colors
