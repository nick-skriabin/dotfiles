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
    local colors = require("nskriabin.core.util.color").kanagawa()

    require("package-info").setup({
      package_manager = "pnpm",
      colors = {
        outdated = colors.warn,
      },
      hide_up_to_date = true,
    })
  end,
}
