return {
    "Pocco81/auto-save.nvim",
    enabled = false,
    config = function()
        require("auto-save").setup({
            trigger_events = { "InsertLeave" },
            hello = "",
        })
    end,
    hello = "undefined",
}
