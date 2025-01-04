return {
    { "bullets-vim/bullets.vim" },
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
            -- -- Ensure proper mode handling
            modes = {
                insert = false, -- Don't render in insert mode
                normal = true, -- Render in normal mode
            },
            -- -- Optional: fine-tune rendering
            -- links = {
            --     chase = false, -- Prevent potential spacing issues
            -- },
        },
    },
    {
        "hedyhli/markdown-toc.nvim",
        cmd = "Mtoc",
        keys = {
            { "<leader>mi", ":Mtoc i<cr>", desc = "Insert Table of Contents" },
            { "<leader>mu", ":Mtoc u<cr>", desc = "Update Table of Contents" },
        },
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        enabled = false,
        build = "cd app && yarn install",
        keys = {
            {
                "<leader>mp",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown Preview",
            },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
    {
        "wallpants/github-preview.nvim",
        cmd = { "GithubPreviewToggle" },
        keys = { "<leader>mpt" },
        opts = {
            -- config goes here
        },
        config = function(_, opts)
            local gpreview = require("github-preview")
            gpreview.setup(opts)

            local fns = gpreview.fns
            vim.keymap.set("n", "<leader>mpt", fns.toggle)
            vim.keymap.set("n", "<leader>mps", fns.single_file_toggle)
            vim.keymap.set("n", "<leader>mpd", fns.details_tags_toggle)
        end,
    },
}
