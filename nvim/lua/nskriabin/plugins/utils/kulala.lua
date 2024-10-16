return {
    "mistweaverco/kulala.nvim",
    opts = {},
    keys = {
        {
            "<leader>kr",
            function()
                require("kulala").run()
            end,
            desc = "Run request under cursow",
        },
        {
            "<leader>kR",
            function()
                require("kulala").run_all()
            end,
            desc = "Run all requests in a file",
        },
        {
            "<leader>ke",
            function()
                require("kulala").replay()
            end,
            desc = "Replay last request",
        },
        {
            "<leader>ki",
            function()
                require("kulala").inspect()
            end,
            desc = "Inspect current request",
        },
        {
            "<leader>kp",
            function()
                require("kulala").from_curl()
            end,
            desc = "Paste from cURL",
        },
        {
            "<leader>ky",
            function()
                require("kulala").copy()
            end,
            desc = "Copy request as cURL",
        },
        {
            "<leader>ks",
            function()
                require("kulala").scratchpad()
            end,
            desc = "Request scratchpad",
        },
        {
            "<leader>kx",
            function()
                require("kulala").close()
            end,
            desc = "Close Kulala window",
        },
        {
            "<leader>k]",
            function()
                require("kulala").jump_next()
            end,
            desc = "Jump to the next request",
        },
        {
            "<leader>k[",
            function()
                require("kulala").jump_prev()
            end,
            desc = "Jump to the previous request",
        },
        {
            "<leader>kS",
            function()
                require("kulala").search()
            end,
            desc = "Search a named request",
        },
    },
}
