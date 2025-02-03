local init_highlights = require("nskriabin.core.ui.init_highlights")

return {
    "catppuccin/nvim",
    enabled = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            flavour = "mocha",
            background = {
                dark = "mocha",
                light = "frappe",
            },
            term_colors = true,
            integrations = {
                cmp = true,
                fidget = true,
                lsp_trouble = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = true,
                octo = true,
                which_key = true,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
                navic = {
                    enabled = true,
                    custom_bg = "NONE",
                },
                illuminate = {
                    enabled = true,
                    lsp = true,
                },
            },
        })

        -- vim.cmd([[colorscheme catppuccin]])
        vim.g.zenbones_transparent_background = true
    end,
}
