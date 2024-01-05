local au = require("nskriabin.auto.utils")

au.cmd({ "VimResized" }, {
  group = au.group("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
