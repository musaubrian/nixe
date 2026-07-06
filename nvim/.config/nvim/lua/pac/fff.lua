local fff = require "fff"

fff.setup {
  prompt = "> ",
  title = "Find Files",
  lazy_sync = true,
  debug = { enabled = false },
  layout = {
    height = 0.9,
    width = 0.9,
    prompt_position = "top",
    preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
    preview_size = 0.5,
    flex = { size = 130, wrap = "top" },
    show_scrollbar = true,
    path_shorten_strategy = "end", -- 'middle_number' | 'middle' | 'end'
    anchor = "center",
  },
}

vim.keymap.set("n", "<leader>ff", function()
  fff.find_files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>sn", function()
  fff.find_files_in_dir(vim.fn.stdpath "config")
end, { desc = "" })

vim.keymap.set("n", "<leader>ss", function()
  fff.find_files_in_dir "~/.local/bin/scripts"
end, { desc = "Search scripts" })

vim.keymap.set("n", "<leader>flg", function()
  fff.live_grep()
end, { desc = "Live Grep with FFF" })
