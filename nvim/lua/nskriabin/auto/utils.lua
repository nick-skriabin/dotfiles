local M = {}

M.group = function(name, clear)
    local clear_group = true

    if clear == nil then
        clear_group = clear
    end

    return vim.api.nvim_create_augroup(name, { clear = clear_group })
end

M.cmd = function(events, options)
    vim.api.nvim_create_autocmd(events, options)
end

return M
