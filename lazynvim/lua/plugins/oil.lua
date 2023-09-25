return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", ":lua require('oil').open()<cr>", desc = "Open parent dir", silent = true },
    },
  },
}
