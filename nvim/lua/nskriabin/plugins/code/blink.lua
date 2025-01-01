-- Lightweight and blazingly fast completion engine
-- https://github.com/saghen/blink.cmp

local EMOJI_TRIGGER = ":"
local SNIPPETS_TRIGGER = "~"

-- Allows triggering different sources only when they're
-- preceded by a specified character.
--
-- Credits to @linkazru for the code
local function item_trigger(trigger_char)
    return function()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        return before_cursor:match(trigger_char .. "%w*$") ~= nil
    end
end

-- Will remove the trigger character after completion insertion
--
-- Credits to @linkazru for the code
local function cleanup_input(trigger_char)
    return function(ctx, items)
        -- WARNING: Explicitly referencing ctx otherwise I was getting an "unused" warning
        local _ = ctx
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
        local trigger_pos = before_cursor:find(trigger_char .. "[^" .. trigger_char .. "]*$")
        if trigger_pos then
            for _, item in ipairs(items) do
                item.textEdit = {
                    newText = item.insertText or item.label,
                    range = {
                        start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
                        ["end"] = { line = vim.fn.line(".") - 1, character = col },
                    },
                }
            end
        end
        -- NOTE: After the transformation, I have to reload the luasnip source
        -- Otherwise really crazy shit happens and I spent way too much time
        -- figurig this out
        vim.schedule(function()
            require("blink.cmp").reload("luasnip")
        end)
        return items
    end
end
return {
    "saghen/blink.cmp",
    version = "v0.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets", "moyiz/blink-emoji.nvim" },
    opts = {
        signature = { enabled = true },
        completion = {
            keyword = { range = "prefix" },
        },
        sources = {
            default = { "lsp", "snippets", "path", "buffer", "emoji" },
            providers = {
                lsp = {
                    name = "lsp",
                    module = "blink.cmp.sources.lsp",
                    score_offset = 95,
                    max_items = 15,
                    -- as LSP can be a source of snippets,
                    -- they will show up after SNIPPETS_TRIGGER as well.
                    -- we need to clean them up as we do with regular snippets
                    transform_items = cleanup_input(SNIPPETS_TRIGGER),
                },
                snippets = {
                    module = "blink.cmp.sources.snippets",
                    name = "Snippets",
                    score_offset = 85,
                    max_items = 10,
                    min_keyword_length = 2,
                    should_show_items = item_trigger(SNIPPETS_TRIGGER),
                    transform_items = cleanup_input(SNIPPETS_TRIGGER),
                },
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = 50, -- Tune by preference
                    max_items = 10,
                    min_keyword_length = 2,
                    should_show_items = item_trigger(EMOJI_TRIGGER),
                    transform_items = cleanup_input(EMOJI_TRIGGER),
                },
                path = {
                    name = "Path",
                    module = "blink.cmp.sources.path",
                    score_offset = 10,
                    fallbacks = { "luasnip", "buffer" },
                    opts = {
                        trailing_slash = false,
                        label_trailing_slash = true,
                        get_cwd = function(context)
                            return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                        end,
                        show_hidden_files_by_default = true,
                    },
                },
                buffer = {
                    name = "Buffer",
                    module = "blink.cmp.sources.buffer",
                    -- Only show buffer completions when inside a comment
                    should_show_items = function(ctx)
                        local bufnr = 0 -- current buffer
                        local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
                        row = row - 1 -- Convert to 0-based index

                        local parser = vim.treesitter.get_parser(bufnr)
                        if not parser then
                            return false
                        end

                        local tree = parser:parse()[1]
                        local root = tree:root()

                        local node = root:named_descendant_for_range(row, col, row, col)
                        while node do
                            if node:type() == "comment" then
                                return true
                            end
                            node = node:parent()
                        end

                        return false
                    end,
                },
            },
        },
        keymap = {
            -- set to 'none' to disable the 'default' preset
            preset = "default",

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        },
    },
}
