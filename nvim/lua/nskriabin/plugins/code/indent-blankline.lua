local highlight = {
    "IndentLine",
}
return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function(opts)
        local hooks = require("ibl.hooks")
        local colors = require("nskriabin.core.util.color").kanagawa()
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentLine", { fg = colors.textDimmed })
        end)
        require("ibl").setup({
            indent = { highlight = highlight },
            exclude = {
                filetypes = {
                    "dashboard",
                },
            },
        })
    end,
}
