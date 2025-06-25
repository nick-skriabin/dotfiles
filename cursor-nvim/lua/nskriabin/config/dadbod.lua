local au = require("nskriabin.auto.utils")
local M = {}

function M.setup()
    vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
    vim.g.vim_dadbod_completion_mark = ""
end

return M
