return {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "ibhagwan/fzf-lua", -- optional
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_vtext = require("nvim-dap-virtual-text")

        dapui.setup()
        dap_vtext.setup()

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
        },
        {
            "<leader>dB",
            function()
                require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end,
            desc = "Conditional Breakpoint",
        },
        {
            "<leader>de",
            function()
                require("dap").eval()
            end,
        },
        {
            "<leader>dO",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },
        {
            "<leader>do",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step In",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
        },
        {

            "<leader>dt",
            function()
                require("dap").terminate()
            end,
            desc = "Terminate",
        },
        {
            "<leader>du",
            function()
                require("dapui").toggle()
            end,
            desc = "Toggle UI",
        },
    },
}
