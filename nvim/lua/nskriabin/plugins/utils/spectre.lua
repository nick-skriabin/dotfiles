return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    --default = {
    --replace = {
    --cmd = "oxi",
    --},
    --},
  },
  keys = {
    { "<leader>sR", ":lua require('spectre').toggle()<cr>", silent = true, desc = "Find and replace" },
  },
}
