-- Lightweight and blazingly fast completion engine
-- https://github.com/saghen/blink.cmp

return {
    "saghen/blink.cmp",
    version = "v0.*",
    dependencies = "rafamadriz/friendly-snippets",

    opts = {
        highlight = {
            -- sets the fallback highlight groups to nvim-cmp's highlight groups
            -- useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release, assuming themes add support
            use_nvim_cmp_as_default = true,
        },
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",

        -- experimental auto-brackets support
        -- accept = { auto_brackets = { enabled = true } }

        -- experimental signature help support
        -- trigger = { signature_help = { enabled = true } },

        -- keymap settings
        keymap = {
            preset = "default",
        },
    },
}
