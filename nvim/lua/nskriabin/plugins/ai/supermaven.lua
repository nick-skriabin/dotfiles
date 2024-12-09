return {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<Tab>",
                clear_suggestion = "<C-]>",
                accept_word = "<C-j>",
            },
            ignore_filetypes = {
                "cpp",
                "spectre_panel",
            }, -- or { "cpp", }
            log_level = "info", -- set to "off" to disable logging completely
            disable_inline_completion = false, -- disables inline completion for use with cmp
            disable_keymaps = false, -- disables built in keymaps for more manual control
            condition = function()
                return false
            end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
        })
    end,
}