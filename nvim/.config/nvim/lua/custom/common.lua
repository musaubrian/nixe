local M = {}

--- Generate a short id using uuidgen
--- @return string | nil
M.GenId = function()
  local ok, uuid = pcall(vim.fn.system, "uuidgen")
  if not ok then
    vim.notify("Failed to gen uuid", vim.log.levels.ERROR)
    return nil
  end

  -- .*%- matches everything up to the last -
  -- (.+)$ captures what's after it (the last segment)
  local short = uuid:match(".*%-(.+)$"):gsub("\n", "")

  return short
end

return M
