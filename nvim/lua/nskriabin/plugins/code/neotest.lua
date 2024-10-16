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
                    cmd = "yarn jest --detectOpenHandles",
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
            desc = "Run Nearest Test [Neotest]",
        },
        {
            "<leader>tc",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            silent = true,
            desc = "Run Tests In Current File [Neotest]",
        },
        {
            "<leader>td",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            silent = true,
            desc = "Tests With DAP [Neotest]",
        },
        {
            "<leader>ts",
            function()
                require("neotest").run.stop()
            end,
            silent = true,
            desc = "Stop Running Tests [Neotest]",
        },
        {
            "<leader>to",
            function()
                require("neotest").output.open()
            end,
            silent = true,
            desc = "Open Output [Neotest]",
        },
        {
            "<leader>tt",
            function()
                require("neotest").summary.toggle()
            end,
            silent = true,
            desc = "Toggle Summary [Neotest]",
        },
        {
            "<leader>tp",
            function()
                require("neotest").jump.prev()
            end,
            silent = true,
            desc = "Previous Test [Neotest]",
        },
        {
            "<leader>tn",
            function()
                require("neotest").jump.next()
            end,
            silent = true,
            desc = "Next Test [Neotest]",
        },
    },
}
