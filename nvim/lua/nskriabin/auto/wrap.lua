local au = require("nskriabin.auto.utils")

au.cmd({ "BufReadPre" }, {
    group = au.group("markdown"),
    pattern = { ".md", ".mdx" },
    command = "setlocal wrap linebreak",
})
