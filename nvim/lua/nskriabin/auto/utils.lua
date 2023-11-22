local M = {}

M.group = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

M.cmd = function(events, options)
  vim.api.nvim_create_autocmd(events, options)
end

return M
