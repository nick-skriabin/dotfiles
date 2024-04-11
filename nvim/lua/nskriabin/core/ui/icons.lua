local M = {}

M.misc = {
    dots = "󰇘",
    file = "󰈔",
    readonly_file = "󰈡",
    file_plus = "󱪝",
    recording = "󰑊",
    modified = "",
}

M.lsps = {
    tailwindcss = "󱏿",
    svelte = "",
    rust = "",
    ["lua_ls"] = "󰢱",
    vtsls = "",
    tsserver = "",
    emmet_language_server = "",
    biome = "󰬉",
    jsonls = "󰘦",
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
