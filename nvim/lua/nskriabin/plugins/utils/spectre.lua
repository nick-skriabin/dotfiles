return {
    "nvim-pack/nvim-spectre",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>sR", ":lua require('spectre').toggle()<cr>", silent = true, desc = "Find and [R]eplace" },
        {
            "<leader>sF",
            function()
                local spectre = require("spectre")
                local plenary = require("plenary")
                local path = plenary.path:new(vim.fn.expand("%:p:h")):make_relative()

                spectre.toggle({ cwd = path })
            end,
            silent = true,
            desc = "[F]ind in current directory",
        },
    },
}
