local oil = require "oil"
oil.setup {
  -- columns = { "permissions", "icon" },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-k>"] = false,
    ["<C-j>"] = false,
    ["<M-h>"] = "actions.select_split",
  },
  view_options = { show_hidden = true },
}

vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
