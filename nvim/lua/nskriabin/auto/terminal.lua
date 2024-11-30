local au = require("nskriabin.auto.utils")

au.cmd({ "TermOpen" }, {
    group = au.group("terminal"),
    callback = function()
        vim.cmd("setlocal nonumber norelativenumber nospell")
    end,
})
