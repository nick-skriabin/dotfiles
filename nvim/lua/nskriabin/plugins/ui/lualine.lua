local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local mode = function(palette, icons)
    return {
        -- mode component
        function()
            local labels = {
                ["n"] = "N",
                ["no"] = "O-P",
                ["nov"] = "O-P",
                ["noV"] = "O-P",
                ["no\22"] = "O-P",
                ["niI"] = "N",
                ["niR"] = "N",
                ["niV"] = "N",
                ["nt"] = "N",
                ["ntT"] = "N",
                ["v"] = "V",
                ["vs"] = "V",
                ["V"] = "L",
                ["Vs"] = "L",
                ["\22"] = "B",
                ["\22s"] = "B",
                ["s"] = "S",
                ["S"] = "S",
                ["\19"] = "SE-B",
                ["i"] = "I",
                ["ic"] = "I",
                ["ix"] = "I",
                ["R"] = "R",
                ["Rc"] = "R",
                ["Rx"] = "R",
                ["Rv"] = "VI-R",
                ["Rvc"] = "VI-R",
                ["Rvx"] = "VI-R",
                ["c"] = "C",
                ["cv"] = "X",
                ["ce"] = "X",
                ["r"] = "R",
                ["rm"] = "M",
                ["r?"] = "R?",
                ["!"] = "$S",
                ["t"] = "$T",
            }

            local mode = vim.fn.mode()
            local label = labels[mode]

            return label or mode
        end,
        color = function()
            -- auto change color according to neovims mode
            local mode_color = {
                n = palette.red,
                i = palette.green,
                v = palette.blue,
                [""] = palette.lavender,
                V = palette.lavender,
                c = palette.lavender,
                no = palette.red,
                s = palette.peach,
                S = palette.peach,
                [""] = palette.peach,
                ic = palette.yellow,
                R = palette.maroon,
                Rv = palette.maroon,
                cv = palette.red,
                ce = palette.red,
                r = palette.teal,
                rm = palette.teal,
                ["r?"] = palette.teal,
                ["!"] = palette.red,
                t = palette.red,
            }
            return { fg = mode_color[vim.fn.mode()], gui = "bold" }
        end,
        padding = { left = 1, right = 1 },
    }
end

local diagnostics = function(palette, icons)
    return {
        "diagnostics",
        symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
        },
    }
end

local lsp = function(palette, icons)
    return {
        -- Lsp server name .
        function()
            local msg = "No Active Lsp"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return msg
            end
            local attached = {}
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    local icon = icons.lsps[client.name] or client.name
                    table.insert(attached, icon)
                end
            end
            if #attached > 0 then
                return table.concat(attached, " ")
            else
                return msg
            end
        end,
        color = { fg = palette.sky, gui = "bold" },
    }
end

local macro_recording = function(palette, icons)
    return {
        function()
            local recording_register = vim.fn.reg_recording()
            if recording_register == "" then
                return ""
            else
                return recording_register
            end
        end,
        icon = icons.misc.recording,
        color = { fg = palette.text },
        padding = { left = 1, right = 1 },
    }
end

local function maximize_status()
    return vim.t.maximized and "   " or ""
end

local function is_tmux_attached()
    return vim.fn.system("IPFS_SESSION=$(tmux attach-session -t ipfs 2>&1)"):find("sessions should be nested")
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        local icons = require("nskriabin.core.ui.icons")
        local Util = require("nskriabin.core.util")
        local palette = require("nskriabin.core.util.color").current()
        local ccspinner = require("nskriabin.core.plugins.codecompanion-lualine")

        local sections = {
            -- these are to remove the defaults
            lualine_a = {},
            lualine_b = {},
            lualine_y = {},
            lualine_z = {},
            -- These will be filled later
            lualine_c = {},
            lualine_x = {},
        }

        local add_left = function(cfg)
            table.insert(sections.lualine_b, cfg)
        end

        local add_right = function(cfg)
            table.insert(sections.lualine_y, cfg)
        end

        -- add_left({ "mode" })
        add_left(mode(palette, icons))
        add_left({
            "filetype",
            separator = "",
            cond = conditions.buffer_not_empty,
        })
        add_left({
            "filename",
            path = 4,
            symbols = {
                modified = icons.misc.modified,
                readonly = icons.misc.readonly_file,
                unnamed = "",
                newfile = icons.misc.file_plus,
            },
            cond = conditions.buffer_not_empty,
        })
        add_left({ "location" })
        add_left({ maximize_status })
        add_left({
            function()
                return "%="
            end,
        })

        -- local notifications = require("nskriabin.core.extensions.lualine.gh-notifications")
        -- add_right(notifications(palette, icons))
        add_right(macro_recording(palette, icons))
        add_right(ccspinner)
        add_right(lsp(palette, icons))
        if not is_tmux_attached() then
            add_right({
                "branch",
            })
            add_right({
                "diff",
                symbols = {
                    added = icons.git.added,
                    modified = icons.git.modified,
                    removed = icons.git.removed,
                },
            })
        end
        add_right(diagnostics(palette, icons))
        add_right({
            function()
                return "  " .. require("dap").status()
            end,
            cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = Util.fg("Debug"),
        })

        return {
            options = {
                component_separators = "",
                section_separators = "",
                theme = {
                    normal = { a = { bg = "" }, b = { fg = palette.text, bg = "black" } },
                    inactive = { a = { bg = "" }, b = { fg = palette.text, bg = "black" } },
                },
                globalstatus = true,
            },
            sections = sections,
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
            extensions = { "neo-tree", "lazy" },
        }
    end,
}
