local au = require("nskriabin.auto.utils")
local M = {}

local function db_completion()
  require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

function M.setup()
  vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
  vim.g.vim_dadbod_completion_mark = ""

  local group = au.group("dadbod")

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return M
