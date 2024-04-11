local border_opts = {
    border = nil,
    winhighlight = "Normal:CmpNormal,NormalFloat:CmpNormalFloat,FloatBorder:TelescopeBorder",
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = "║",
}

local function indexof(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

local function get_lsp_kinds_ordering()
    local lsp_kind = require("cmp.types.lsp").CompletionItemKind

    return {
        lsp_kind.Variable,
        lsp_kind.Value,
        lsp_kind.Field,
        lsp_kind.EnumMember,
        lsp_kind.Property,
        lsp_kind.TypeParameter,
        lsp_kind.Method,
        lsp_kind.Module,
        lsp_kind.Function,
        lsp_kind.Constructor,
        lsp_kind.Interface,
        lsp_kind.Class,
        lsp_kind.Struct,
        lsp_kind.Enum,
        lsp_kind.Constant,
        lsp_kind.Unit,
        lsp_kind.Keyword,
        lsp_kind.Snippet,
        lsp_kind.Color,
        lsp_kind.File,
        lsp_kind.Folder,
        lsp_kind.Event,
        lsp_kind.Operator,
        lsp_kind.Reference,
        lsp_kind.Text,
    }
end

return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind.nvim",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function(_, opts)
            local cmp = require("cmp")
            local lsp = require("cmp.types.lsp")
            local lspkind = require("lspkind")
            local luasnip = require("luasnip")
            local cmp_npar = require("nvim-autopairs.completion.cmp")
            local insert = cmp.SelectBehavior.Insert
            local lspKinds = lsp.CompletionItemKind
            local kind_ordering = get_lsp_kinds_ordering()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.event:on("confirm_done", cmp_npar.on_confirm_done())

            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
                sources = {
                    { name = "dap" },
                },
            })

            cmp.setup({
                preselect = false,
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = insert }), { "i" }),
                    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = insert }), { "i" }),
                    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = insert }), { "i" }),
                    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = insert }), { "i" }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "codeium" },
                    { name = "nvim_lsp" },
                    { name = "dap" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        local kind = lspkind.cmp_format({
                            mode = "symbol_text", -- show only symbol annotations
                            maxwidth = 50,
                            ellipsis_char = "...",
                            show_labelDetails = true,
                            symbol_map = {
                                Codeium = "",
                            },
                        })(entry, item)

                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. ""
                        kind.menu = "  (" .. (strings[2] or "") .. ")"
                        item.dup = 0

                        return kind
                    end,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = border_opts,
                    documentation = border_opts,
                },
                enabled = function()
                    -- disable completion in comments
                    local context = require("cmp.config.context")
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        function(e1, e2)
                            local kind1 = e1:get_kind()
                            local kind2 = e2:get_kind()

                            if kind1 == kind2 then
                                return nil
                            end

                            local kind1_index = indexof(kind_ordering, kind1) or 100
                            local kind2_index = indexof(kind_ordering, kind2) or 100

                            return kind1_index < kind2_index
                        end,
                        cmp.config.compare.score,
                        cmp.config.compare.kind,
                        function(entry1, entry2)
                            local kind1 = entry1:get_kind()
                            local kind2 = entry2:get_kind()
                            kind1 = kind1 == lspKinds.Text and 100 or kind1
                            kind2 = kind2 == lspKinds.Text and 100 or kind2
                            if kind1 ~= kind2 then
                                if kind1 == lspKinds.Snippet then
                                    return false
                                end
                                if kind2 == lspKinds.Snippet then
                                    return true
                                end
                                local diff = kind1 - kind2
                                if diff < 0 then
                                    return true
                                elseif diff > 0 then
                                    return false
                                end
                            end
                        end,
                        cmp.config.compare.exact,
                        cmp.config.compare.offset,
                        cmp.config.compare.length,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.order,
                    },
                },
                experimental = {
                    ghost_text = true,
                },
            })

            local cmdline_mapping = cmp.mapping.preset.cmdline({
                ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = insert }), { "i" }),
                ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = insert }), { "i" }),
                ["<C-y>"] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),
            })

            cmp.setup.cmdline(":", {
                mapping = cmdline_mapping,
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "Man", "!" },
                        },
                    },
                }),
            })

            cmp.setup.cmdline("/", {
                mapping = cmdline_mapping,
                sources = cmp.config.sources({
                    { name = "buffer" },
                }),
            })
        end,
    },
}
