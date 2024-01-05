local au = require("nskriabin.auto.utils")

au.cmd("TextYankPost", {
  group = au.group("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
