local servers = require("nskriabin.core.lsp.servers")
local merge = require("nskriabin.core.util.merge")
local auto = require("nskriabin.auto.utils")

local configs = {
  ["svelte"] = {
    settings = {
      svelte = {
        ["enable-ts-plugin"] = true,
        plugin = {
          css = {
            completions = {
              emmet = false,
            },
          },
          html = {
            completions = {
              emmet = false,
            },
            tagComplete = {
              enable = false,
            },
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      auto.cmd("BufWritePost", {
        pattern = { "*.js", "*.ts" },
        group = auto.group("svelte"),

        callback = function(ctx)
          -- Here use ctx.match instead of ctx.file
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
        end,
      })
    end,
  },
  ["vtsls"] = {
    settings = {
      typescript = {
        format = {
          enable = false,
        },
        tsserver = {
          maxTsServerMemory = "auto",
          --log = "verbose",
          --trace = "verbose",
        },
        updateImportsOnFileMove = "always",
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      javascript = {
        format = {
          enable = false,
        },
        updateImportsOnFileMove = "always",
      },
    },
  },
  ["lua_ls"] = {
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  },
  ["emmet_language_server"] = {
    filetypes = {
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "pug",
      "typescriptreact",
      "svelte",
    },
    init_options = {
      showAbbreviationSuggestions = false,
      showSuggestionsAsSnippets = false,
    },
  },
}

local function get_config(name, capabilities, on_attach)
  local server_config = configs[name] or {}

  local overriden_on_attach = function(client, bufnr)
    if server_config.on_attach then
      server_config.on_attach(client, bufnr)
    end
    on_attach(client, bufnr)
  end

  local config = merge({
    capabilities = capabilities,
    on_attach = overriden_on_attach,
  }, server_config)

  return config
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "yioneko/nvim-vtsls",
    "SmiteshP/nvim-navic",
    "folke/neoconf.nvim",
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")
    require("lspconfig.configs").vtsls = require("vtsls").lspconfig

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }

    local navic_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    local on_attach = function(client, bufnr)
      navic_attach(client, bufnr)

      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      map.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Show LSP definitions"
      map.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      map.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      map.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      map.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "See available source actions"
      map.set("n", "<leader>cA", function()
        vim.lsp.buf.code_action({
          context = {
            only = { "source" },
            diagnostics = {},
          },
        })
      end, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Rename Symbol"
      map.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" }) -- smart rename

      opts.desc = "Show buffer diagnostics"
      map.set("n", "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      map.set("n", "gl", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      map.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      map.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      map.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    for _, name in pairs(servers.lsp) do
      lspconfig[name].setup(get_config(name, capabilities, on_attach))
    end
  end,
}
