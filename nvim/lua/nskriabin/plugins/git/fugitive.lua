return {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git" },
    keys = {
        {
            "<leader>ga",
            function()
                local current_file_path = vim.fn.expand("%")
                vim.cmd("Git add " .. current_file_path)
            end,
            silent = true,
            desc = "Stage current file",
        },
    },
}
