local vim = vim
local validate = vim.validate
local Path = require("nskriabin.core.util.path")
local M = {}

-- For zipfile: or tarfile: virtual paths, returns the path to the archive.
-- Other paths are returned unaltered.
local function strip_archive_subpath(path)
    -- Matches regex from zip.vim / tar.vim
    path = vim.fn.substitute(path, "zipfile://\\(.\\{-}\\)::[^\\\\].*$", "\\1", "")
    path = vim.fn.substitute(path, "tarfile:\\(.\\{-}\\)::.*$", "\\1", "")
    return path
end

local function search_ancestors(start_path, func)
    validate({ func = { func, "f" } })
    if func(start_path) then
        return start_path
    end
    local guard = 100
    for path in Path.iterate_parents(start_path) do
        -- Prevent infinite recursion if our algorithm breaks
        guard = guard - 1
        if guard == 0 then
            return
        end

        if func(path) then
            return path
        end
    end
end

function M.root_pattern(...)
    local patterns = vim.tbl_flatten({ ... })
    return function(start_path)
        start_path = strip_archive_subpath(start_path)
        for _, pattern in ipairs(patterns) do
            local match = search_ancestors(start_path, function(path)
                local paths = Path.join(Path.escape_wildcards(path), pattern)
                local globs = vim.fn.glob(paths, true, true)

                for _, p in ipairs(globs) do
                    if Path.exists(p) then
                        return path
                    end
                end
            end)

            if match ~= nil then
                return match
            end
        end
    end
end

return M
