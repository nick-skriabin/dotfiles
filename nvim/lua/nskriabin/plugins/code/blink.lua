-- Lightweight and blazingly fast completion engine
-- https://github.com/saghen/blink.cmp

return {
    "saghen/blink.cmp",
    version = "v0.*",
    event = { "InsertEnter", "CmdlineEnter" },
    -- dependencies = "rafamadriz/friendly-snippets",
    opts = {
        keymap = {
            -- set to 'none' to disable the 'default' preset
            preset = "default",

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },

            -- show with a list of providers
            ["<C-space>"] = {
                function(cmp)
                    cmp.show({ providers = { "snippets" } })
                end,
            },
        },
        signature = { enabled = true },
    },
}
