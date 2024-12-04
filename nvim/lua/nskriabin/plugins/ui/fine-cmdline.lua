return {
    "hachy/cmdpalette.nvim",
    enabled = false,
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("cmdpalette").setup({
            buf = {
                filetype = "cmdpalette",
            },
        })

        require("cmp").setup.filetype("cmdpalette", {
            sources = {
                { name = "cmdline" },
            },
        })

        vim.api.nvim_create_autocmd("filetype", {
            pattern = "cmdpalette",
            callback = function()
                vim.keymap.set("i", "<Tab>", function()
                    require("cmp").complete()
                end, { buffer = true })
            end,
        })
    end,
}
