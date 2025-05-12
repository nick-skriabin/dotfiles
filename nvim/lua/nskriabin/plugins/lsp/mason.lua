return {
    "mason-org/mason.nvim",
    lazy = true,
    cmd = { "Mason" },
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")
        local servers = require("nskriabin.core.lsp.servers")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = servers.lsp,
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_tool_installer.setup({
            ensure_installed = servers.tools,
            automatic_installation = true,
        })
    end,
}
