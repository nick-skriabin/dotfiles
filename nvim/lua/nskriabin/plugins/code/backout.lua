return {
  "AgusDOLARD/backout.nvim",
  event = "InsertEnter",
  opts = {},
  keys = {
    -- Define your keybinds
    { "<C-b>", "<cmd>lua require('backout').back()<cr>", mode = { "i" } },
    { "<C-n>", "<cmd>lua require('backout').out()<cr>", mode = { "i" } },
  },
}
