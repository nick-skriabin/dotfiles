local init_highlights = require("nskriabin.core.ui.init_highlights")

return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
        -- Default options:
        require("kanagawa").setup({
            compile = false, -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true, -- do not set background color
            dimInactive = false, -- dim inactive window `:h hl-NormalNC`
            theme = "dragon", -- Load "wave" theme when 'background' option is not set
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                    dragon = {
                        fg_dim = "#fujiGray",
                    },
                },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                    NoiceCmdlinePopup = { bg = theme.ui.bg_m3 },

                    -- Telescope
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_m3 },
                    TelescopePromptBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                    -- CMP
                    CmpNormal = { bg = theme.ui.bg_p1 },
                    CmpNormalFloat = { bg = theme.ui.bg_p1 },

                    -- Popup menu
                    PmenuSel = { blend = 0 },

                    FidgetTask = { link = "NormalFloat" },
                    FidgetTitle = { link = "NormalFloat" },

                    OilGitStatusIndexAdded = { fg = theme.diff.add },
                    OilGitStatusIndexModified = { fg = theme.diff.change },
                    OilGitStatusIndexDeleted = { fg = theme.diff.removed },
                    OilGitStatusWorkingTreeAdded = { fg = theme.diff.add },
                    OilGitStatusWorkingTreeModified = { fg = theme.diff.change },
                    OilGitStatusWorkingTreeDeleted = { fg = theme.diff.removed },
                }
            end,
        })

        init_highlights("kanagawa")
        -- setup must be called before loading
        vim.cmd("colorscheme kanagawa-dragon")
    end,
}
