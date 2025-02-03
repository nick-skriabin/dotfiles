return {
    { "echasnovski/mini.starter" },
    {
        "echasnovski/mini.pairs",
        event = "InsertEnter",
        opts = {
            mappings = {
                ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

                [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

                ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
            },
        },
    },
    {
        "echasnovski/mini.ai",
        event = "BufRead",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
    },
    {
        "echasnovski/mini.files",
        lazy = false,
        enabled = false,
        dependencies = {
            "echasnovski/mini.animate",
        },
        keys = {
            {
                "-",
                ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<cr>",
                desc = "Open mini.files (Directory of Current File)",
                silent = true,
            },
            {
                "_",
                ":lua MiniFiles.open(vim.uv.cwd(), true)<cr>",
                desc = "Open mini.files (cwd)",
                silent = true,
            },
        },
        opts = {
            mappings = {
                close = "q",
                go_in = "",
                go_in_plus = "L",
                go_out = "h",
                go_out_plus = "-",
                mark_goto = "'",
                mark_set = "m",
                reset = "<BS>",
                reveal_cwd = "_",
                show_help = "g?",
                synchronize = "<C-w>",
                trim_left = "<",
                trim_right = ">",
            },
            window = {
                preview = true,
            },
        },
        config = function(_, opts)
            local MiniFiles = require("mini.files")

            local show_dotfiles = true
            local filter_show = function(fs_entry)
                return true
            end
            local filter_hide = function(fs_entry)
                return not vim.startswith(fs_entry.name, ".")
            end

            local toggle_dotfiles = function()
                show_dotfiles = not show_dotfiles
                local new_filter = show_dotfiles and filter_show or filter_hide
                require("mini.files").refresh({ content = { filter = new_filter } })
            end

            local files_set_cwd = function()
                local cur_entry_path = MiniFiles.get_fs_entry().path
                local cur_directory = vim.fs.dirname(cur_entry_path)
                if cur_directory ~= nil then
                    vim.fn.chdir(cur_directory)
                end
            end

            local map_split = function(buf_id, lhs, direction, close_on_file)
                local rhs = function()
                    local new_target_window
                    local cur_target_window = require("mini.files").get_explorer_state().target_window
                    if cur_target_window ~= nil then
                        vim.api.nvim_win_call(cur_target_window, function()
                            vim.cmd("belowright " .. direction .. " split")
                            new_target_window = vim.api.nvim_get_current_win()
                        end)

                        require("mini.files").set_target_window(new_target_window)
                        require("mini.files").go_in({ close_on_file = close_on_file })
                    end
                end

                local desc = "Open in " .. direction .. " split"
                if close_on_file then
                    desc = desc .. " and close"
                end
                vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
            end

            MiniFiles.setup(opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id

                    vim.keymap.set(
                        "n",
                        opts.mappings and opts.mappings.toggle_hidden or "g.",
                        toggle_dotfiles,
                        { buffer = buf_id, desc = "Toggle hidden files" }
                    )

                    vim.keymap.set(
                        "n",
                        opts.mappings and opts.mappings.change_cwd or "gc",
                        files_set_cwd,
                        { buffer = args.data.buf_id, desc = "Set cwd" }
                    )

                    map_split(buf_id, opts.mappings and opts.mappings.go_in_horizontal or "<C-w>s", "horizontal", false)
                    map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical or "<C-w>v", "vertical", false)
                    map_split(
                        buf_id,
                        opts.mappings and opts.mappings.go_in_horizontal_plus or "<C-w>S",
                        "horizontal",
                        true
                    )
                    map_split(buf_id, opts.mappings and opts.mappings.go_in_vertical_plus or "<C-w>V", "vertical", true)
                end,
            })

            -- Function to open file and close mini.files
            local function open_file_and_close()
                require("mini.files").go_in({ close_on_file = true })
            end

            -- Create an autocommand to set up the custom mapping
            vim.api.nvim_create_autocmd("User", {
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    -- Map 'l' key to open file and close mini.files
                    vim.api.nvim_buf_set_keymap(buf_id, "n", "<cr>", "", {
                        callback = open_file_and_close,
                        desc = "Open file and close mini.files",
                        noremap = true,
                        silent = true,
                    })
                end,
            })
        end,
    },
    {
        "echasnovski/mini.icons",
        opts = {},
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        opts = {},
        config = "true",
    },
}
