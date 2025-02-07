local au = require("nskriabin.auto.utils")
return {
    "folke/snacks.nvim",
    priority = 2000,
    lazy = false,
    event = "VeryLazy",
    keys = {
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete.delete()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>bo",
            function()
                Snacks.bufdelete.other()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>bD",
            function()
                Snacks.bufdelete.all()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>gb",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame",
        },
        {
            "<leader>nh",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Show Notification History",
        },
        {
            "<leader>nu",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Dismiss Notifications",
        },
        {
            "<leader>zz",
            function()
                Snacks.zen()
            end,
        },
        {
            "<leader><space>",
            function()
                Snacks.picker("smart")
            end,
        },
        {
            "<leader>,",
            function()
                Snacks.picker("buffers")
            end,
        },
        {
            "<leader>gb",
            function()
                Snacks.picker("git_branches")
            end,
        },
        {
            "<leader>r",
            function()
                Snacks.picker("grep")
            end,
        },
        {
            "<leader>.",
            function()
                Snacks.picker("projects")
            end,
        },
    },
    config = function()
        local Snacks = require("snacks")

        Snacks.setup({
            animate = {
                enabled = true,
                duration = 20, -- ms per step
                easing = "linear",
                fps = 60, -- frames per second. Global setting for all animations
            },
            picker = {
                enabled = true,
                formatters = {
                    file = {
                        filename_first = true,
                        truncate = 120,
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<C-c>"] = { "close", mode = { "i", "n" } },
                            ["<C-y>"] = { "confirm", mode = { "i", "n" } },
                        },
                    },
                },
            },
            dim = { enabled = true },
            indent = {
                enabled = true,
                indent = {
                    only_scope = true,
                    only_active = true,
                },
                chunk = { enabled = true },
            },
            input = { enabled = false },
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            nofify = { enabled = true },
            notifier = { enabled = true, style = "minimal" },
            lazygit = { enabled = true },
            terminal = { enabled = true },
            git = { enabled = true },
            rename = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { icon = " ", titlE = "Projects", section = "projects", indent = 2, padding = 1, width = 100 },
                    { section = "startup" },
                },
            },
            quickfile = { enabled = true },
            statuscolumn = {
                enabled = true,
                left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                right = { "fold", "git" }, -- priority of signs on the right (high to low)
                folds = {
                    open = false, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { "GitSign", "MiniDiffSign" },
                },
                refresh = 50, -- refresh at most every 50ms
            },
            words = { enabled = false },
            zen = { enabled = true },
        })

        ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
        local progress = vim.defaulttable()
        au.cmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        au.cmd("LspProgress", {
            ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                if not client or type(value) ~= "table" then
                    return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                    if i == #p + 1 or p[i].token == ev.data.params.token then
                        p[i] = {
                            token = ev.data.params.token,
                            msg = ("[%3d%%] %s%s"):format(
                                value.kind == "end" and 100 or value.percentage or 100,
                                value.title or "",
                                value.message and (" **%s**"):format(value.message) or ""
                            ),
                            done = value.kind == "end",
                        }
                        break
                    end
                end

                local msg = {} ---@type string[]
                progress[client.id] = vim.tbl_filter(function(v)
                    return table.insert(msg, v.msg) or not v.done
                end, p)

                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(table.concat(msg, "\n"), "info", {
                    id = "lsp_progress",
                    title = client.name,
                    opts = function(notif)
                        notif.icon = #progress[client.id] == 0 and " "
                            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                    end,
                })
            end,
        })
    end,
}
