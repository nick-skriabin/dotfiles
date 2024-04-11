local DEBUGGER_PATH = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
local EXECUTABLE = "/Applications/Arc.app/Contents/MacOS/Arc"
local USER_DATA_DIR = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
local icons = require("nskriabin.core.ui.icons")

local M = {}

M.lang = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "svelte",
}

M.setup = function()
    local dap = require("dap")
    local dapui = require("dapui")

    for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
            "Dap" .. name,
            { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
    end

    for _, language in ipairs(M.lang) do
        require("dap").configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
            },
            -- Debug nodejs processes (make sure to add --inspect when you run the process)
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require("dap.utils").pick_process,
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
            },
            -- Debug web applications (client side)
            {
                type = "pwa-chrome",
                request = "launch",
                name = "Launch & Debug Chrome",
                url = function()
                    local co = coroutine.running()
                    return coroutine.create(function()
                        vim.ui.input({
                            prompt = "Enter URL: ",
                            default = "http://localhost:3000",
                        }, function(url)
                            if url == nil or url == "" then
                                return
                            else
                                coroutine.resume(co, url)
                            end
                        end)
                    end)
                end,
                webRoot = vim.fn.getcwd(),
                protocol = "inspector",
                sourceMaps = true,
                userDataDir = false,
            },
        }
    end

    dapui.setup()

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
end

return M
