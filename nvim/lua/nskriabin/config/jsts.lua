local DEBUGGER_PATH = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"
local EXECUTABLE = "/Applications/Arc.app/Contents/MacOS/Arc"

local M = {}

M.setup = function()
  local dap_vscode = require("dap-vscode-js")
  local dap = require("dap")
  local dapui = require("dapui")

  dap_vscode.setup({
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    -- debugger_cmd = { "js-debug-adapter" },
    adapters = {
      "pwa-node",
      "pwa-chrome",
      "pwa-msedge",
      "node-terminal",
      "pwa-extensionHost",
    }, -- which adapters to register in nvim-dap
  })

  dap.adapters.language = function(cb, config)
    if config.request == " attach" then
      cb({ type = "server", port = 9222 })
    elseif config.request == "launch" then
      cb({ type = "executable", command = EXECUTABLE })
    end
  end

  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
    }
  end

  for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
    require("dap").configurations[language] = {
      {
        type = "pwa-chrome",
        name = "Launch Chrome",
        request = "launch",
        url = "http://localhost:3002",
        webRoot = "${workspaceFolder}",
        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
      },
    }
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
