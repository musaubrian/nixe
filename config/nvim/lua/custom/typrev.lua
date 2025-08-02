local M = {
  currentFile = "",
  previewCmd = "",

  typstJobId = nil,
  prevJobId = nil,
}

M.setup = function(opts)
  M.previewCmd = opts.previewCmd
end

vim.api.nvim_create_user_command("Typ", function()
  M.currentFile = vim.fn.expand "%:p"
  local ft = vim.bo.filetype

  if string.len(M.currentFile) == 0 then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  if ft ~= "typst" then
    vim.notify("Not a typst file, ignoring", vim.log.levels.INFO)
    return
  end

  local previewFile = M.currentFile:match "(.+)%." .. "." .. "pdf"

  if M.typstJobId and M.prevJobId then
    vim.notify("Already watching file", vim.log.levels.INFO)
    return
  end

  M.typstJobId = vim.fn.jobstart { "typst", "watch", M.currentFile }

  if vim.uv.fs_stat(previewFile) then
    -- we already have this file, previewer should handle updating it
    M.prevJobId = vim.fn.jobstart { M.previewCmd, previewFile }
  else
    -- slight delay because typst takes a bit of time
    vim.defer_fn(function()
      M.prevJobId = vim.fn.jobstart { M.previewCmd, previewFile }
    end, 1000)
  end

  print("Watching: " .. vim.fn.expand "%")
end, {})

vim.api.nvim_create_user_command("Styp", function()
  if M.typstJobId == nil and M.prevJobId == nil then
    vim.notify "Nothing to stop"
    return
  end

  if M.typstJobId and M.prevJobId then
    vim.fn.jobstop(M.typstJobId)
    vim.fn.jobstop(M.prevJobId)

    M.typstJobId = nil
    M.prevJobId = nil
  end

  if M.typstJobId then
    vim.fn.jobstop(M.typstJobId)
    M.typstJobId = nil
  end

  if M.prevJobId then
    vim.fn.jobstop(M.prevJobId)
    M.prevJobId = nil
  end

  vim.notify "Stopped previewing"
end, {})

vim.keymap.set("n", "<leader>pr", "<cmd>:Typ<CR>", { desc = "Start typst previewer" })
vim.keymap.set("n", "<leader>spr", "<cmd>:Styp<CR>", { desc = "Stop typst previewer" })

return M
