require("nskriabin.core")
local ts = require("vim.treesitter.query")

ts.set(
    "javascript",
    "injections",
    [[
  ((call_expression
    function: (member_expression
      object: (_) 
      property: (property_identifier) @func (#eq? @func "$queryRaw"))
    arguments: (template_string) @sql)
    (#set! injection.language "sql"))
]]
)

ts.set(
    "typescript",
    "injections",
    [[
  ((call_expression
    function: (member_expression
      object: (_) 
      property: (property_identifier) @func (#eq? @func "$queryRaw"))
    arguments: (template_string) @sql)
    (#set! injection.language "sql"))
]]
)
