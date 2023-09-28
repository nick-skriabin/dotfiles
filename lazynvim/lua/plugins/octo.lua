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
  end,
  keys = {
    { "<leader>oo", "<cmd>Octo<cr>", desc = "Octo" },
    { "<leader>opl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>opl", "<cmd>Octo pr search<cr>", desc = "Search PRs" },
    { "<leader>ors", "<cmd>Octo review start<cr>", desc = "Start Review" },
    { "<leader>ord", "<cmd>Octo review discard<cr>", desc = "Discard Reviewe" },
    { "<leader>orc", "<cmd>Octo review continue<cr>", desc = "Continue Review" },
  },
}
