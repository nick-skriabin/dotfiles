local border_opts = {
    border = nil,
    winhighlight = "Normal:CmpNormal,NormalFloat:CmpNormalFloat,FloatBorder:TelescopeBorder",
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = "║",
}
return {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "VeryLazy", -- Load nvim-cmp when entering command-line mode
    dependencies = {
        "hrsh7th/cmp-cmdline", -- Command-line completion source
        "hrsh7th/cmp-path", -- Path completion source
    },
    config = function()
        local cmp = require("cmp")
        local window_settings = {

            completion = border_opts,
            documentation = border_opts,
        }

        cmp.setup({
            enabled = function()
                return vim.bo.filetype == "cmdpalette" or vim.api.nvim_get_mode().mode == "c"
            end,

            window = window_settings,

            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
        })

        local cmdline_mapping = cmp.mapping.preset.cmdline({
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { "i" }),
            ["<C-y>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            }),
        })
        cmp.setup.cmdline(":", {
            window = window_settings,
            mapping = cmdline_mapping,
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })

        cmp.setup.cmdline("/", {
            window = window_settings,
            mapping = cmdline_mapping,
            sources = cmp.config.sources({
                { name = "buffer" },
            }),
        })
    end,
}
