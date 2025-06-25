local M = {}
local h = require("nskriabin.core.util.helpers")

local function keymap(mode, key, command, opts)
    local map = vim.keymap.set
    map(mode, key, command, opts)
end

M.map = function(keys_table)
    for _, value in pairs(keys_table) do
        local options = h.deep_copy(value)
        local modes = table.remove(options, 1)
        local key = table.remove(options, 1)
        local command = table.remove(options, 1)

        if options.silent == nil then
            options.silent = true
        end

        if options.noremap == nil then
            options.noremap = true
        end

        keymap(modes, key, command, options)
    end
end

M.normal = function(keys_table)
    local alt = {}
    for _, value in pairs(keys_table) do
        local options = h.deep_copy(value)
        local key = table.remove(options, 1)
        local command = table.remove(options, 1)

        local mapping = { "n", key, command, options }

        table.insert(alt, mapping)
    end

    M.map(alt)
end

return M
