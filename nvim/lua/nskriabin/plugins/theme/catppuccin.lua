local hl = vim.api.nvim_set_hl
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      flavour = "mocha",
      integrations = {
        cmp = false,
        fidget = true,
        lsp_trouble = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        octo = true,
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
        illuminate = {
          enabled = true,
          lsp = true,
        },
        telescope = {
          enabled = false,
        },
      },
    })

    local colors = require("nskriabin.core.util.color")
    local bg = colors.base
    local fg = colors.text

    hl(0, "NoiceCmdlinePopup", { bg = bg })
    hl(0, "TelescopeNormal", { bg = bg, fg = fg })
    hl(0, "TelescopeBorder", { bg = bg, fg = bg })
    hl(0, "TelescopePromptBorder", { bg = bg, fg = bg })
    hl(0, "CmpNormal", { bg = bg })
    hl(0, "CmpNormalFloat", { bg = bg })
    hl(0, "PmenuSel", { blend = 0 })

    vim.cmd([[colorscheme catppuccin]])
  end,
}
