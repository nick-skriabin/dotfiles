return {
  {
    "tpope/vim-dadbod",
    lazy = true,
    config = function()
      require("nskriabin.config.dadbod").setup()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    keys = {
      { "<leader>id", "<cmd>DBUIToggle<cr>", silent = true, desc = "Open DB UI" },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
