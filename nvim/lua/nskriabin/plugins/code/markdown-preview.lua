return {
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
}
