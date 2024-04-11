local icons = require("nskriabin.core.ui.icons")
local js_based_languages = {
    "typescript",
    "javascript",
    "typescriptreact",
    "javascriptreact",
    "vue",
}

return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")

        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        for name, sign in pairs(icons.dap) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end

        for _, language in ipairs(js_based_languages) do
            dap.configurations[language] = {
                -- Debug single nodejs files
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = vim.fn.getcwd(),
                    webRoot = "${workspaceFolder}",
                    sourceMaps = true,
                },
                -- Debug nodejs processes (make sure to add --inspect when you run the process)
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    processId = require("dap.utils").pick_process,
                    cwd = vim.fn.getcwd(),
                    webRoot = "${workspaceFolder}",
                    sourceMaps = true,
                },
                {
                    type = "pwa-chrome",
                    request = "attach",
                    name = "Attach Program (pwa-chrome = { port: 9222 })",
                    program = "${file}",
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    port = 9222,
                    webRoot = "${workspaceFolder}",
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                },
            }
        end
    end,
    keys = {
        {
            "<leader>ds",
            function()
                if vim.fn.filereadable(".vscode/launch.json") then
                    local dap_vscode = require("dap.ext.vscode")
                    dap_vscode.load_launchjs(nil, {
                        ["pwa-node"] = js_based_languages,
                        ["chrome"] = js_based_languages,
                        ["pwa-chrome"] = js_based_languages,
                    })
                end
                require("dap").continue()
            end,
            desc = "Start",
        },
    },
    dependencies = {
        -- Install the vscode-js-debug adapter
        {
            "microsoft/vscode-js-debug",
            -- After install, build it and rename the dist directory to out
            build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
            version = "1.*",
        },
        {
            "mxsdev/nvim-dap-vscode-js",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("dap-vscode-js").setup({
                    -- Path of node executable. Defaults to $NODE_PATH, and then "node"
                    -- node_path = "node",

                    -- Path to vscode-js-debug installation.
                    debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),

                    -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
                    -- debugger_cmd = { "js-debug-adapter" },

                    -- which adapters to register in nvim-dap
                    adapters = {
                        "chrome",
                        "pwa-node",
                        "pwa-chrome",
                        "pwa-msedge",
                        "pwa-extensionHost",
                        "node-terminal",
                    },

                    -- Path for file logging
                    -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

                    -- Logging level for output to file. Set to false to disable logging.
                    -- log_file_level = false,

                    -- Logging level for output to console. Set to false to disable console output.
                    -- log_console_level = vim.log.levels.ERROR,
                })
            end,
        },
        {},
        {
            "Joakker/lua-json5",
            build = "./install.sh",
        },
    },
}
