local lsp_dir = vim.fn.stdpath "config" .. "/lsp"
local clients = {}

for name, type in vim.fs.dir(lsp_dir) do
  if type == "file" then
    local client = name:match "(.+)%.%w+$"
    table.insert(clients, client)
  end
end

vim.defer_fn(function()
  vim.lsp.enable(clients)
end, 500)
