local highlight = {
    "IndentLine",
}
return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function(opts)
        local hooks = require("ibl.hooks")
        local colors = require("nskriabin.core.util.color").current()
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentLine", { fg = colors.border })
        end)
        require("ibl").setup({
            indent = {
                highlight = highlight,
                char = "▏",
                tab_char = "▏",
            },
            exclude = {
                filetypes = {
                    "dashboard",
                },
            },
        })
    end,
}
