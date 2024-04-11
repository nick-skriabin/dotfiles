local function toggle_telescope(harpoon_files, conf)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
        .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
                results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end

local HP = {}

function HP.add(harpoon)
    harpoon:list():append()
end

function HP.remove(harpoon)
    harpoon:list():remove()
end

function HP.list(harpoon, conf)
    harpoon.ui:toggle_quick_menu(harpoon:list())
end

function HP.next(harpoon)
    harpoon:list():next()
end

function HP.prev(harpoon)
    harpoon:list():prev()
end

function HP.clear(harpoon)
    harpoon:list():clear()
end

local function init_command(harpoon, telescope_conf)
    vim.api.nvim_create_user_command("Harpoon", function(opts)
        if opts.args == nil or opts.args == "" or opts.args == "list" then
            HP.list(harpoon, telescope_conf)
        elseif opts.args == "add" then
            HP.add(harpoon)
        elseif opts.args == "remove" then
            HP.remove(harpoon)
        elseif opts.args == "next" then
            HP.next(harpoon)
        elseif opts.args == "prev" then
            HP.prev(harpoon)
        elseif opts.args == "clear" then
            HP.clear(harpoon)
        end
    end, {
        nargs = "?",
        complete = function()
            return { "add", "remove", "list", "next", "prev", "clear" }
        end,
    })
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    cmd = "Harpoon",
    lazy = true,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {},
    keys = {
        { "<leader>ha", ":Harpoon add<cr>", desc = "Add file", silent = true },
        { "<leader>hd", ":Harpoon remove<cr>", desc = "Remove file", silent = true },
        { "<leader>ho", ":Harpoon list<cr>", desc = "Open list", silent = true },
        { "<leader>hh", ":Harpoon next<cr>", desc = "Next file", silent = true },
        { "<leader>hp", ":Harpoon prev<cr>", desc = "Prev file", silent = true },
    },
    config = function()
        local harpoon = require("harpoon")
        local telescope_conf = require("telescope.config").values
        harpoon:setup()
        init_command(harpoon, telescope_conf)
    end,
}
