return {
  "pwntester/octo.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("octo").setup({
      enable_builtin = true,
    })

    vim.cmd([[hi OctoEditable guibg=none]])
    vim.treesitter.language.register("markdown", "octo")
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
