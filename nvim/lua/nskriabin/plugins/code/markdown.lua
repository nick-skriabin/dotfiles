return {
    { "bullets-vim/bullets.vim" },
    { "MeanderingProgrammer/render-markdown.nvim" },
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