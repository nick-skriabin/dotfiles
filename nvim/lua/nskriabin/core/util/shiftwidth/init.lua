local M = {}

-- Generic configuration file reader
function M.read_config_file(filename, parser)
    local config_path = vim.fn.findfile(filename, vim.fn.getcwd())

    if config_path == "" then
        return nil
    end

    local file_contents = vim.fn.readfile(vim.fn.getcwd() .. "/" .. config_path)

    if not file_contents or #file_contents == 0 then
        return nil
    end

    local ok, config = pcall(parser, file_contents)
    if not ok then
        vim.notify("Error parsing " .. filename .. ": " .. tostring(config), vim.log.levels.WARN)
        return nil
    end

    return config
end

-- JSON parser
function M.parse_json(file_path)
    local content = vim.fn.readfile(file_path)
    return vim.fn.json_decode(content)
end

-- TOML parser (requires a TOML library like 'toml')
function M.parse_toml(file_path)
    -- Write contents to a temporary file

    -- Use yq to convert TOML to JSON
    -- Using eval-all (-ea) to parse TOML and output as JSON
    vim.notify(file_path, "warn")
    local cmd = string.format("yq -yo -j '.' %s", vim.fn.shellescape(file_path))
    local result = vim.fn.system(cmd)

    -- Check for command execution errors
    if vim.v.shell_error ~= 0 then
        vim.notify("Error parsing TOML with yq: " .. result, vim.log.levels.WARN)
        return nil
    end

    -- Parse the JSON output
    local ok, parsed = pcall(vim.fn.json_decode, result)
    if not ok then
        vim.notify("Error decoding JSON from yq: " .. tostring(parsed), vim.log.levels.WARN)
        return nil
    end

    return parsed
end

-- Unified shiftwidth setter
function M.set_shiftwidth(indent)
    if indent and type(indent) == "number" then
        vim.bo.shiftwidth = indent
        vim.bo.tabstop = indent
    end
end

-- Configuration readers for specific formatters
M.formatter_configs = {
    stylua = {
        filename = "stylua.toml",
        parser = M.parse_toml,
        indent_getter = function(config)
            return config.indent_type == "Spaces" and config.indent_width or nil
        end,
    },
    biome = {
        filename = "biome.json",
        parser = M.parse_json,
        indent_getter = function(config)
            return config.formatter and config.formatter.indentWidth or nil
        end,
    },
    prettier = {
        filename = ".prettierrc",
        parser = M.parse_json,
        indent_getter = function(config)
            return config.tabWidth or nil
        end,
    },
    black = {
        filename = "pyproject.toml",
        parser = M.parse_toml,
        indent_getter = function(config)
            -- Black typically uses 4-space indents
            return config.tool and config.tool.black and config.tool.black.line_length and 4 or nil
        end,
    },
}

-- Generic function to set shiftwidth based on formatter config
function M.set_shiftwidth_from_formatter(formatter_name)
    local formatter_config = M.formatter_configs[formatter_name]
    if not formatter_config then
        return false
    end

    local config = M.read_config_file(formatter_config.filename, formatter_config.parser)
    if not config then
        return false
    end

    local indent = formatter_config.indent_getter(config)
    M.set_shiftwidth(indent)

    return true
end

-- Create autocommands for multiple formatters
function M.setup_formatter_indent_autocommands(formatters)
    for formatter, filetypes in pairs(formatters) do
        vim.api.nvim_create_autocmd("BufRead", {
            pattern = filetypes,
            callback = function()
                M.set_shiftwidth_from_formatter(formatter)
            end,
        })
    end
end

return M
