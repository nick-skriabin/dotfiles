return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "marilari88/neotest-vitest",
        "marilari88/neotest-jest",
        "thenbe/neotest-playwright",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-vitest"),
                require("neotest-jest")({
                    cmd = "yarn test",
                    env = {
                        NODE_ENV = "test",
                    },
                }),
                require("neotest-playwright").adapter({
                    options = {
                        persist_project_selection = true,
                        enable_dynamic_test_discovery = true,
                    },
                }),
            },
        })
    end,
    keys = {
        {
            "<leader>tr",
            function()
                require("neotest").run.run()
            end,
            silent = true,
            desc = "Run tests in current project",
        },
        {
            "<leader>tc",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            silent = true,
            desc = "Run tests in current file",
        },
        {
            "<leader>td",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            silent = true,
            desc = "Run nearest test with debug",
        },
        {
            "<leader>ts",
            function()
                require("neotest").run.stop()
            end,
            silent = true,
            desc = "Stop currently running tests",
        },
        {
            "<leader>to",
            function()
                require("neotest").output.open()
            end,
            silent = true,
            desc = "Open test output",
        },
        {
            "<leader>tO",
            function()
                require("neotest").summary.open()
            end,
            silent = true,
            desc = "Open test output",
        },
    },
}
