return {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    config = function()
        require("codeium").setup({})
    end,
}
