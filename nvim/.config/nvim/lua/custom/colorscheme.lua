if vim.o.background == "light" then
  vim.cmd.colorscheme "default"

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
else
  vim.cmd.colorscheme "jed"
end
