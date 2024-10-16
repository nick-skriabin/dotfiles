return {
    "tummetott/reticle.nvim",
    event = "VeryLazy", -- optionally lazy load the plugin
    opts = {
        on_startup = {
            cursorline = true,
            cursorcolumn = true,
        },
        -- add options here if you wish to override the default settings
        never = {
            cursorline = {
                "dashboard",
                "oil",
            },

            cursorcolumn = {
                "dashboard",
                "oil",
            },
        },
    },
}
