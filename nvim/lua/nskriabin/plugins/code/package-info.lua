return {
  "vuki656/package-info.nvim",
  event = { "BufReadPre" },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>cpt", "<cmd>lua require('package-info').toggle()<cr>", silent = true, desc = "Toggle Info" },
    { "<leader>cpa", "<cmd>lua require('package-info').install()<cr>", silent = true, desc = "Install Package" },
    { "<leader>cpr", "<cmd>lua require('package-info').delete()<cr>", silent = true, desc = "Remove Package" },
    { "<leader>cpu", "<cmd>lua require('package-info').update()<cr>", silent = true, desc = "Update Package" },
    {
      "<leader>cpv",
      "<cmd>lua require('package-info').change_verion()<cr>",
      silent = true,
      desc = "Change Package Version",
    },
  },
  config = function()
    local pallete = require("catppuccin.palettes").get_palette("mocha")

    require("package-info").setup({
      package_manager = "pnpm",
      colors = {
        outdated = pallete.peach,
      },
      hide_up_to_date = true,
    })
  end,
}
