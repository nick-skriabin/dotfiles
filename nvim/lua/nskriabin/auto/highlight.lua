local au = require("nskriabin.auto.utils")

au.cmd("TextYankPost", {
    group = au.group("highlight_yank"),
    callback = function()
        print("yank")
        vim.highlight.on_yank()
    end,
})
