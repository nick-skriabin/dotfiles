return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    if require("lazyvim.util").has("noice.nvim") then
      opts.defaults["<leader>o"] = { name = "+Octo" }
      opts.defaults["<leader>op"] = { name = "+Octo PR" }
      opts.defaults["<leader>or"] = { name = "+Octo Review" }
    end
  end,
}
