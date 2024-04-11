local init_highlights = require("nskriabin.core.ui.init_highlights")

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            flavour = "mocha",
            integrations = {
                cmp = false,
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
                telescope = {
                    enabled = false,
                },
            },
        })

        vim.cmd([[colorscheme catppuccin]])

        init_highlights("catppuccin")
    end,
}
