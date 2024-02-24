local auto = require("nskriabin.auto.utils")
local DEFAULT_OPTIONS = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = true, -- "Name" codes like Blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode = "background", -- Set the display mode.
}
return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local colorizer = require("colorizer")
        local fts = {
            "css",
            "stylus",
            "sass",
            "javascript",
            "typescript",
            "javascript.react",
            "typescript.react",
            "html",
        }

        colorizer.setup(fts)

        auto.cmd({
            "InsertLeave",
            "BufWritePost",
        }, {
            group = auto.group("Colorizer"),
            pattern = {
                "*.css",
                "*.styl",
                "*.sass",
                "*.js",
                "*.ts",
                "*.jsx",
                "*.tsx",
                "*.html",
                "*.svelte",
            },
            callback = function()
                colorizer.reload_all_buffers()
            end,
        })
    end,
}
