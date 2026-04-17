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
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)

    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    vim.wo.foldenable = false -- stops nvim from folding on buffer load (file open)

    local select = require "vim.treesitter._select"

    vim.keymap.set({ "x", "n" }, "<C-Space>", function()
      if vim.fn.mode() == "n" then
        vim.cmd "normal! v" -- enter visual mode first
      end
      select.select_parent(vim.v.count1)
    end, { desc = "TS: increment node selection" })

    vim.keymap.set("x", "<M-Space>", function()
      select.select_child(vim.v.count1) -- shrink / go to child
    end, { desc = "TS: decrement node selection" })
  end,
})
