return {
    "folke/neoconf.nvim",
    enabled = false,
    lazy = false,
    config = function()
        require("neoconf").setup({})
    end,
}
