local M = {}
local uv = vim.loop
local is_windows = uv.os_uname().version:match("Windows")

-- Some path utilities
function M.escape_wildcards(path)
    return path:gsub("([%[%]%?%*])", "\\%1")
end

--- @param path string
--- @return string
function M.sanitize(path)
    if is_windows then
        path = path:sub(1, 1):upper() .. path:sub(2)
        path = path:gsub("\\", "/")
    end
    return path
end

--- @param filename string
--- @return string|false
function M.exists(filename)
    local stat = uv.fs_stat(filename)
    return stat and stat.type or false
end

--- @param filename string
--- @return boolean
function M.is_dir(filename)
    return M.exists(filename) == "directory"
end

--- @param filename string
--- @return boolean
function M.is_file(filename)
    return M.exists(filename) == "file"
end

--- @param path string
--- @return boolean
function M.is_fs_root(path)
    if is_windows then
        return path:match("^%a:$")
    else
        return path == "/"
    end
end

--- @param filename string
--- @return boolean
function M.is_absolute(filename)
    if is_windows then
        return filename:match("^%a:") or filename:match("^\\\\")
    else
        return filename:match("^/")
    end
end

--- @generic T: string?
--- @param path T
--- @return T
function M.dirname(path)
    local strip_dir_pat = "/([^/]+)$"
    local strip_sep_pat = "/$"
    if not path or #path == 0 then
        return path
    end
    local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
    if #result == 0 then
        if is_windows then
            return path:sub(1, 2):upper()
        else
            return "/"
        end
    end
    return result
end

function M.join(...)
    return table.concat(vim.tbl_flatten({ ... }), "/")
end

-- Traverse the path calling cb along the way.
function M.traverse_parents(path, cb)
    path = uv.fs_realpath(path)
    local dir = path
    -- Just in case our algo is buggy, don't infinite loop.
    for _ = 1, 100 do
        dir = M.dirname(dir)
        if not dir then
            return
        end
        -- If we can't ascend further, then stop looking.
        if cb(dir, path) then
            return dir, path
        end
        if M.is_fs_root(dir) then
            break
        end
    end
end

-- Iterate the path until we find the rootdir.
function M.iterate_parents(path)
    local function it(_, v)
        if v and not M.is_fs_root(v) then
            v = M.dirname(v)
        else
            return
        end
        if v and uv.fs_realpath(v) then
            return v, path
        else
            return
        end
    end
    return it, path, path
end

function M.is_descendant(root, path)
    if not path then
        return false
    end

    local function cb(dir, _)
        return dir == root
    end

    local dir, _ = M.traverse_parents(path, cb)

    return dir == root
end

M.path_separator = is_windows and ";" or ":"

return M
