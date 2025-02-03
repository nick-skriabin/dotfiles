return {
    { "bullets-vim/bullets.vim", event = { "BufReadPre" } },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "3rd/image.nvim" },
        opts = {
            bullet = {
                icons = { "●", "○", "◆", "◇" },
                icons_enabled = true,
                left_pad = 2,
                right_pad = 1,
            },
            -- Ensure proper mode handling
            links = {
                chase = false, -- Prevent potential spacing issues
            },
        },
    },
}
