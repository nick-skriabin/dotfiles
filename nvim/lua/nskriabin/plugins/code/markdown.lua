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
        build = "cd app && yarn install",
        keys = {
            {
                "<leader>cp",
                ft = "markdown",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown Preview",
            },
        },
        config = function()
            vim.cmd([[do FileType]])
        end,
    },
}
