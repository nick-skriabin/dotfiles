return {
  "kevinhwang91/nvim-ufo",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    "kevinhwang91/promise-async",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    vim.o.foldcolumn = "0" -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

    require("ufo").setup()
  end,
  keys = {
    { "zR", ":lua require('ufo').openAllFolds()<cr>", desc = "Open all folds", silent = true },
    { "zM", ":lua require('ufo').closeAllFolds()<cr>", desc = "Open all folds", silent = true },
    { "zK", ":lua require('ufo').peekFoldedLinesUnderCursor()<cr>", desc = "Peek fold", silent = true },
  },
}
