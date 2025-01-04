local au = require("nskriabin.auto.utils")

au.cmd({ "BufReadPre" }, {
    group = au.group("markdown"),
    pattern = { "*.md", "*.mdx" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})
