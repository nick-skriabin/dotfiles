local au = require("nskriabin.auto.utils")

au.cmd({ "BufReadPre" }, {
    group = au.group("markdown"),
    command = "setlocal wrap linebreak",
})
