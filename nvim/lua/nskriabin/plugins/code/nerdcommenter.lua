return {
  "preservim/nerdcommenter",
  lazy = false,
  init = function()
    vim.g.NERDCreateDefaultMappings = false
  end,
  keys = {
    { "<leader>/", "<Plug>NERDCommenterToggle<cr>", desc = "Toggle comment", mode = { "n", "v" } },
  },
}
