return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    "ThePrimeagen/harpoon",
  },
  opts = {},
  keys = {
    { "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", desc = "Add file", silent = true },
    { "<leader>hd", ":lua require('harpoon.mark').remove_file()<cr>", desc = "Remove file", silent = true },
    { "<leader>ho", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "List marks", silent = true },
    { "<leader>hh", ":lua require('harpoon.ui').nav_next()<cr>", desc = "Next file", silent = true },
  },
}
