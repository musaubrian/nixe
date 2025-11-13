--- @class Snippet
--- @field trig string
--- @field desc? string
--- @field body string|string[]

--- @alias SnipStore table<string, Snippet[]>

--- @class Opts
--- @field name string name to be used in the package.json

--- @class SnipManager
--- @field snip_store SnipStore
--- @field opts Opts
local M = {
  snip_store = {},
  opts = { name = "snippy-gen" },
}

--- Create a new snippet
--- @param snippet SnipStore
function M.add(snippet)
  for lang, snippet_list in pairs(snippet) do
    M.snip_store[lang] = M.snip_store[lang] or {}
    for _, s in ipairs(snippet_list) do
      table.insert(M.snip_store[lang], s)
    end
  end
end

--- @param opts Opts
function M.setup(opts)
  M.snip_store = {}
  M.opts = opts or M.opts
end

local function escape_quotes(s)
  return s:gsub('"', '\\"')
end

--- Normalize body into a single string
--- @param body string|string[]
local function norm_body(body)
  if type(body) == "string" then
    return string.format('"%s"', escape_quotes(body))
  end

  local parts = {}
  for _, b in ipairs(body) do
    table.insert(parts, string.format('"%s"', escape_quotes(b)))
  end

  return table.concat(parts, ",")
end

--- @param name string
--- @param contents Snippet[]
local function write_snip_file(name, contents)
  local file = io.open(name, "w")
  if file == nil then
    return
  end

  local snips = {}
  for _, snippet in ipairs(contents) do
    table.insert(
      snips,
      string.format(
        [["%s":{"prefix":"%s","body":[%s],"description":"%s"}]],
        snippet.trig,
        snippet.trig,
        norm_body(snippet.body),
        snippet.desc
      )
    )
  end

  file:write(string.format("{%s}", table.concat(snips, ",")))
  file:close()
end

--- @param base_path string
local function create_package_json(base_path)
  local pkg_location = base_path .. "/package.json"
  local file = io.open(pkg_location, "w")
  if file == nil then
    return
  end

  local snippets = {}
  for lang, _ in pairs(M.snip_store) do
    table.insert(snippets, string.format('{"language": "%s", "path": "%s"}', lang, "./" .. lang .. ".json"))
  end

  local pkg_contents =
    string.format('{"name": "%s", "contributes": { "snippets": [%s]}}', M.opts.name, table.concat(snippets, ","))
  file:write(pkg_contents)
end

--- @param store SnipStore
local function create_snippet_files(store)
  local snippets_location = vim.fn.stdpath "config" .. "/snippets"

  for lang, snippet in pairs(store) do
    write_snip_file(snippets_location .. "/" .. lang .. ".json", snippet)
  end

  create_package_json(snippets_location)
end

vim.api.nvim_create_user_command("GenSnippets", function()
  if next(M.snip_store) == nil then
    vim.notify("[WARN] No snippets found, skipping", vim.log.levels.WARN)
    return
  end

  create_snippet_files(M.snip_store)
  vim.notify("[SUCCESS] Snippets generated", vim.log.levels.INFO)
end, {})

return M
