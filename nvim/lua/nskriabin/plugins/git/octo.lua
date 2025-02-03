return {
    "pwntester/octo.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua", -- optional
        { "echasnovski/mini.icons", version = false },
        "folke/which-key.nvim",
    },
    cmd = "Octo",
    config = function()
        require("octo").setup({
            picker = "fzf-lua",
            enable_builtin = true,
        })

        vim.cmd([[hi OctoEditable guibg=none]])
        vim.treesitter.language.register("markdown", "octo")

        local wk = require("which-key")

        wk.add({
            { "<localleader>a", group = "Assignees" },
            { "<localleader>g", group = "Navigate 🗺️" },
            { "<localleader>l", group = "Labels 🏷️" },
            { "<localleader>r", group = "Reactions 😄" },
            { "<localleader>p", group = "PR" },
            { "<localleader>ps", group = "Squash" },
            { "<localleader>pr", group = "Rebase" },
            { "<localleader>i", group = "Issues 🐞" },
            { "<localleader>c", group = "Comment 💬" },
            { "<localleader>s", group = "Suggestion" },
            { "<localleader>v", group = "Review 👀" },
        })
    end,
    keys = {
        { "<leader>oo", "<cmd>Octo<cr>", desc = "Octo" },

        -- PRs
        { "<leader>opl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
        { "<leader>ops", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
        { "<leader>opu", "<cmd>Octo pr url<cr>", desc = "Copy PR url" },
        { "<leader>opc", "<cmd>Octo pr create<cr>", desc = "Create PR" },

        -- Reviews
        { "<leader>ors", "<cmd>Octo review start<cr>", desc = "Start Review" },
        { "<leader>orS", "<cmd>Octo review submit<cr>", desc = "Submit Review" },
        { "<leader>ord", "<cmd>Octo review discard<cr>", desc = "Discard Reviewe" },
        { "<leader>orc", "<cmd>Octo review continue<cr>", desc = "Continue Review" },
    },
}
