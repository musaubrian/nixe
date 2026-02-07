require "custom.opts"
require "custom.user"
require "custom.keys"
require "custom.jade"
require "custom.snips"

local function gh(path)
  return "https://github.com/" .. path
end

local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if kind == "install" or kind == "update" then
    if name == "blink.cmp" then
      vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path })
      vim.notify("Built <" .. name .. ">")
    end
  end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add {
  { src = gh "tpope/vim-fugitive" },
  { src = gh "musaubrian/minline.nvim" },
  { src = gh "wakatime/vim-wakatime" },
  { src = gh "junegunn/vim-easy-align" },
  { src = gh "norcalli/nvim-colorizer.lua" },
  { src = gh "tpope/vim-sleuth" },
  { src = gh "mbbill/undotree" },
  { src = gh "musaubrian/scratch.nvim" },
  { src = gh "stevearc/dressing.nvim" },
  { src = gh "stevearc/oil.nvim" },
  { src = gh "stevearc/conform.nvim" },
  { src = gh "lewis6991/gitsigns.nvim" },
  { src = gh "musaubrian/pye.nvim" },
  { src = gh "nvim-telescope/telescope.nvim" },
  { src = gh "nvim-lua/plenary.nvim" },
  { src = gh "saghen/blink.cmp" },
  { src = gh "nvim-treesitter/nvim-treesitter" },
}

require "pac.simple"
require "pac.lsp"
require "pac.oil"
require "pac.telescope"
require "pac.blink"
require "pac.conform"
