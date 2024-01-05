return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
  },
  event = "InsertEnter",
  keys = { ":" },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", {
      link = "Comment",
      default = true,
    })

    local cmp = require("cmp")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup(opts)

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<Down>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<Up>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-j>"] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<C-k>"] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Insert,
        }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i" }),
      }),
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
  end,
  opts = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local luasnip = require("luasnip")

    local border_opts = {
      border = nil,
      winhighlight = "Normal:CmpNormal,NormalFloat:CmpNormalFloat,FloatBorder:TelescopeBorder",
      zindex = 1001,
      scrolloff = 0,
      col_offset = 0,
      side_padding = 1,
      scrollbar = "║",
    }

    local next_item = cmp.mapping(
      cmp.mapping.select_next_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      { "i", "c" }
    )

    local prev_item = cmp.mapping(
      cmp.mapping.select_prev_item({
        behavior = cmp.SelectBehavior.Insert,
      }),
      { "i", "c" }
    )

    return {
      preselect = cmp.PreselectMode.Item,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Up>"] = prev_item,
        ["<Down>"] = next_item,
        ["<C-p>"] = prev_item,
        ["<C-n>"] = next_item,
        ["<C-k>"] = prev_item,
        ["<C-j>"] = next_item,
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.select })
            else
              cmp.confirm()
            end
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s", "c" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "dap", priority = 900 },
        { name = "luasnip", priority = 1100 },
        { name = "path", priority = 120 },
      }, {
        { name = "buffer" },
      }),
      formatting = {
        format = function(_, item)
          item.dup = {
            nvim_lsp = 1,
            dap = 1,
            luasnip = 1,
            cmp_tabnine = 1,
            buffer = 1,
            path = 1,
          }
          local icons = require("nskriabin.core.ui.icons").kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = border_opts,
        documentation = border_opts,
      },
      sorting = defaults.sorting,
    }
  end,
}
