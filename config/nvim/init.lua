require "custom.user"
require "custom.opts"
require "custom.keys"
require "custom.snips"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" } }, {
  change_detection = {
    notify = false,
  },
})

local lsp_dir = vim.fn.stdpath "config" .. "/lsp"
local clients = {}

for name, type in vim.fs.dir(lsp_dir) do
  if type == "file" then
    local client = name:match "(.+)%.%w+$"
    table.insert(clients, client)
  end
end

vim.lsp.enable(clients)

local typrev = require "custom.typrev"
typrev.setup { previewCmd = "zathura" }
