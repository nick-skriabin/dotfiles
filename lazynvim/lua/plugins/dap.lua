return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { handlers = {} },
      },
      {
        "rcarriga/nvim-dap-ui",
        config = require("plugins.configs.nvim-dap-ui"),
        opts = require("plugins.options.nvim-dap-ui"),
      },
      {
        "rcarriga/cmp-dap",
        dependencies = { "nvim-cmp" },
        config = require("plugins.configs.cmp-dap"),
      },
    },
  },
}
