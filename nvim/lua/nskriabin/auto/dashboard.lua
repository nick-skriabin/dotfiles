local au = require("nskriabin.auto.utils")

---@author kikito
---@see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
local function get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

au.cmd("User", {
  pattern = "BDeletePre",
  group = au.group("dashboard"),
  callback = function(event)
    local found_non_empty_buffer = false
    local buffers = get_listed_buffers()

    for _, bufnr in ipairs(buffers) do
      if not found_non_empty_buffer then
        local name = vim.api.nvim_buf_get_name(bufnr)
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

        if bufnr ~= event.buf and name ~= "" and ft ~= "Dashboard" then
          found_non_empty_buffer = true
        end
      end
    end

    if not found_non_empty_buffer then
      require("neo-tree").close_all()
      vim.cmd([[:Dashboard]])
    end
  end,
})
