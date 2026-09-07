--- Tidos is a simple *actionable items tracking system
--- that uses the TODO.md as taken from suckless software and
--- kinda inspired by @tsoding's tatr
---

local c = require "custom.common"

--- Walk upwards till we find .git
local function find_project_root()
  local root_markers = {
    ".git",
    ".gitignore",
    "TODO.md", -- If we find a TODO first before finding any other marker, use that.
  }

  local cwd = vim.fn.getcwd()
  local home_dir = vim.fn.expand "$HOME"

  while cwd ~= home_dir do
    for _, marker in ipairs(root_markers) do
      if vim.fn.filereadable(cwd .. "/" .. marker) == 1 or vim.fn.isdirectory(cwd .. "/" .. marker) then
        return cwd
      end
    end

    local parent_dir = vim.fn.fnamemodify(cwd, ":h")
    if parent_dir == cwd then
      break
    end
    cwd = parent_dir
  end

  return ""
end

vim.api.nvim_create_user_command("Todo", function()
  local title = vim.fn.input "Title > "

  if title == "" then
    return
  end
  local id = c.GenId()
  if not id or id == "" then
    vim.notify("[TIDOS] Failed to gen id, bailing", vim.log.levels.ERROR)
    return
  end

  local todo_with_id = string.format("TODO(%s)", id)
  local todo_with_title = string.format("%s :: %s", todo_with_id, title)

  local project_root = find_project_root()

  if project_root == "" then
    vim.notify("Failed to get project root", vim.log.levels.ERROR)
    return
  end

  local todo_file = string.format("%s/TODO.md", project_root)
  local file = io.open(todo_file, "a+")
  if file == nil then
    return
  end

  file:write(string.format("- [ ] %s\n\n", todo_with_title))
  file:close()

  vim.fn.setreg("+", todo_with_id, "c")
end, { desc = "Creates a TODO entry in TODO.md at the project root and copies entry to clipboard ('+' register)" })

vim.api.nvim_create_user_command("TComplete", function()
  local todo_id = vim.fn.input "TODO :: "

  local project_root = find_project_root()
  if project_root == "" then
    vim.notify("Failed to get project root", vim.log.levels.ERROR)
    return
  end
  -- stylua: ignore start
  --
  local todo_file  = string.format("%s/TODO.md", project_root)
  local todo_entry = string.format("- \\[ \\] TODO(%s)", todo_id)
  local todo_done  = string.format("- [X] TODO(%s)", todo_id)
  -- stylua: ignore end

  -- cmd::
  -- sed -i.bak 's/- \[ \] TODO(<id>)/- [X] TODO(<id>)/' <file>
  local cmd = string.format("sed -i.bak 's/%s/%s/' %s", todo_entry, todo_done, todo_file)
  local ok, result = pcall(vim.fn.system, cmd)
  if not ok then
    print(vim.inspect(result))
    return
  end

  vim.notify(string.format("TODO(%s) marked as done", todo_id))
end, { desc = "Mark a todo as complete" })
