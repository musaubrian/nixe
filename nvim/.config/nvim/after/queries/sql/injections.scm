((value_definition
  (attribute_id) @_attribute_id
  (let_binding
    body: (string (string_content) @injection.content)))
 (#contains? @_attribute_id "query")
 (#set! injection.language "sql"))
