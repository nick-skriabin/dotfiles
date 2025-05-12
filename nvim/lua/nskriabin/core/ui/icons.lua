local M = {}

M.misc = {
    dots = "󰇘",
    file = "󰈔",
    readonly_file = "󰈡",
    file_plus = "󱪝",
    recording = "󰑊",
    modified = "",
    notifications = "󰂚",
    notifications_new = "󱅫",
}

M.lsps = {
    tailwindcss = "󱏿",
    svelte = "",
    rust = "",
    lua_ls = "󰢱",
    vtsls = "",
    tsserver = "",
    ts_ls = "",
    emmet_language_server = "",
    biome = "󰬉",
    jsonls = "󰘦",
    marksman = "",
    codespell = "󰗊",
    ["nil"] = "",
    bashls = "󱆃",
    clangd = "",
    harper_ls = "󰗊",
    prismals = "",
}

M.dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
}

M.diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

M.git = {
    added = " ",
    modified = " ",
    removed = " ",
}

M.kinds = {
    Array = " ",
    Boolean = " ",
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Namespace = " ",
    Null = " ",
    Number = " ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
    Codeium = "",
}

M.modes = {
    command = "",
}

return M
