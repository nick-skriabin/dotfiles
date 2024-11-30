;extends
(call_expression
  function: (member_expression) @_fn (#match? @_fn "queryRaw")
  (template_string)
  (#set! injection.language "sql")
)
