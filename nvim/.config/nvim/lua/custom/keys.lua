vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>m", ":make<CR>", { desc = "Run make" })
-- Term is back
vim.keymap.set("n", "<leader>tt", ":Term<CR>", { desc = "Open term split bottom" })
vim.keymap.set("n", "<leader>st", ":vs | FTerm<CR>", { desc = "Open term split to right" })

vim.keymap.set("n", "<leader>gs", ":Git<CR>", {})
-- Split size manipulation
vim.keymap.set("n", "<A-[>", ":vertical resize +5<CR>", { desc = "resize split towards left" })
vim.keymap.set("n", "<A-]>", ":vertical resize -5<CR>", { desc = "resize split towards right" })
vim.keymap.set("n", "<A-l>", ":resize +5<CR>", { desc = "resize split downwards" })
vim.keymap.set("n", "<A-L>", ":resize -5<CR>", { desc = "resize split upwards" })
--move highlighted blocks
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
--better indentation
vim.keymap.set("v", "<", "<gv", { desc = "indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right" })

vim.keymap.set("n", "<right>", function()
  vim.notify("Use l to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<left>", function()
  vim.notify("Use h to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<up>", function()
  vim.notify("Use k to move", vim.log.levels.WARN)
end)
vim.keymap.set("n", "<down>", function()
  vim.notify("Use j to move", vim.log.levels.WARN)
end)

vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

--Markdown
vim.keymap.set("n", "<localleader>b", 'viwc**<c-r>"**<esc>', { desc = "Bold text at cursor" })
vim.keymap.set("n", "<localleader>i", 'viwc_<c-r>"_<esc>', { desc = "Italicize text at cursor" })
vim.keymap.set("n", "<localleader>l", 'viwc[<c-r>"]()<left>', { desc = "Convert text on cursor to md link" })
vim.keymap.set("n", "<localleader>`", 'viwc`<c-r>"`<esc>', { desc = "Wrap with backticks" })

vim.keymap.set("n", "<space>rl", ":luafile %<CR>", {})
vim.keymap.set("v", "<space>rl", ":lua<CR>", {})

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {})

vim.keymap.set("n", "<leader>tp", ":tabnext<CR>", {})
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", {})

vim.keymap.set("n", "<leader>pr", ":Typ<CR>", { desc = "Start typst previewer" })
vim.keymap.set("n", "<leader>spr", ":Styp<CR>", { desc = "Stop typst previewer" })

-- [[]]
vim.keymap.set("n", "<leader>oo", ":cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>lg", function()
  local query = vim.fn.input ">> "
  if query == "" then
    return
  end
  vim.cmd(":silent grep! " .. "'" .. query .. "'")
  vim.cmd "copen"
end, { silent = true })

vim.keymap.set("n", "<leader>sw", function()
  local query = vim.fn.expand "<cword>"
  if query == "" then
    vim.notify("Nothing under cursor", vim.log.levels.WARN)
    return
  end

  vim.cmd(":silent grep! " .. "'" .. query .. "'")
  vim.cmd "copen"
end, { silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

vim.keymap.set("n", "<leader>of", function()
  if vim.bo.filetype ~= "odin" then
    vim.notify("Not in an odin file", vim.log.levels.WARN)
    return
  end

  local query = vim.fn.input ">> "
  if query == "" then
    return
  end
  vim.cmd(":silent grep! " .. query .. " ~/thirdparty/odin")
  vim.cmd "copen"
end, { silent = true })
