local border_opts = {
    border = nil,
    winhighlight = "Normal:CmpNormal,NormalFloat:CmpNormalFloat,FloatBorder:TelescopeBorder",
    zindex = 1001,
    scrolloff = 0,
    col_offset = 0,
    side_padding = 1,
    scrollbar = "║",
}

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
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind.nvim",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function(_, opts)
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            local defaults = require("cmp.config.default")()
            local luasnip = require("luasnip")
            local cmp_npar = require("nvim-autopairs.completion.cmp")
            local insert = cmp.SelectBehavior.Insert

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.event:on("confirm_done", cmp_npar.on_confirm_done())

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
