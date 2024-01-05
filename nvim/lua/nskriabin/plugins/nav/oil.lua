return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  opts = {
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    { "-", ":lua require('oil').open()<cr>", desc = "Open parent dir", silent = true },
  },
}
