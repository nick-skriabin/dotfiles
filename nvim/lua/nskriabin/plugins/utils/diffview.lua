return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>gd", ":DiffviewOpen" },
        { "<leader>gD", ":DiffviewClose", desc },
    },
}