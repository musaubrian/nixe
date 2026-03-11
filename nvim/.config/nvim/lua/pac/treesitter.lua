local treesitter = require "nvim-treesitter"
treesitter.setup {
  sync_install = false,
  ignore_install = {},
  modules = {},
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "query",
    "svelte",
    "zig",
    "cpp",
    "python",
  },
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",
    },
  },
}
