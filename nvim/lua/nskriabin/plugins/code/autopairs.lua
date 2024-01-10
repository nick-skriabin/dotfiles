return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {},
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      check_ts = true,
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]",
      fast_wrap = {},
      disable_filetype = {
        "TelescopePrompt",
        "vim",
        "spectre_panel",
      },
    })
  end,
}
