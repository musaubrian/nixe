local fff = require "fff"

-- require('fff').find_files()                        -- find files in current repo
-- require('fff').live_grep()                         -- live content grep
-- require('fff').scan_files()                        -- force rescan
-- require('fff').refresh_git_status()                -- refresh git status
-- require('fff').find_files_in_dir(path)             -- find in a specific dir
-- require('fff').change_indexing_directory(new_path) -- change root
--
--
-- require('fff').setup({
--   base_path = vim.fn.getcwd(),
--   prompt = '> ',
--   title = 'FFFiles',
--   max_results = 100,
--   max_threads = 4,
--   prompt_vim_mode = false,
--   lazy_sync = true,
--   layout = {
--     height = 0.8,
--     width = 0.8,
--     prompt_position = 'bottom',   -- or 'top'
--     preview_position = 'right',   -- 'left' | 'right' | 'top' | 'bottom'
--     preview_size = 0.5,
--     flex = { size = 130, wrap = 'top' },
--     show_scrollbar = true,
--     path_shorten_strategy = 'middle_number', -- 'middle_number' | 'middle' | 'end'
--     anchor = 'center',
--   },
--   preview = {
--     enabled = true,
--     max_size = 10 * 1024 * 1024,
--     chunk_size = 8192,
--     binary_file_threshold = 1024,
--     imagemagick_info_format_str = '%m: %wx%h, %[colorspace], %q-bit',
--     line_numbers = false,
--     cursorlineopt = 'both',
--     wrap_lines = false,
--     filetypes = {
--       svg = { wrap_lines = true },
--       markdown = { wrap_lines = true },
--       text = { wrap_lines = true },
--     },
--   },
--   keymaps = {
--     close = '<Esc>',
--     select = '<CR>',
--     select_split = '<C-s>',
--     select_vsplit = '<C-v>',
--     select_tab = '<C-t>',
--     move_up = { '<Up>', '<C-p>' },
--     move_down = { '<Down>', '<C-n>' },
--     preview_scroll_up = '<C-u>',
--     preview_scroll_down = '<C-d>',
--     toggle_debug = '<F2>',
--     cycle_grep_modes = '<S-Tab>',
--     cycle_previous_query = '<C-Up>',
--     toggle_select = '<Tab>',
--     send_to_quickfix = '<C-q>',
--     focus_list = '<leader>l',
--     focus_preview = '<leader>p',
--   },
--   frecency = {
--     enabled = true,
--     db_path = vim.fn.stdpath('cache') .. '/fff_nvim',
--   },
--   history = {
--     enabled = true,
--     db_path = vim.fn.stdpath('data') .. '/fff_queries',
--     min_combo_count = 3,
--     combo_boost_score_multiplier = 100,
--   },
--   git = {
--     status_text_color = false, -- true to color filenames by git status
--   },
--   grep = {
--     max_file_size = 10 * 1024 * 1024,
--     max_matches_per_file = 100,
--     smart_case = true,
--     time_budget_ms = 150,
--     modes = { 'plain', 'regex', 'fuzzy' },
--     trim_whitespace = false,
--   },
--   debug = { enabled = false, show_scores = false },
--   logging = {
--     enabled = true,
--     log_file = vim.fn.stdpath('log') .. '/fff.log',
--     log_level = 'info',
--   },
-- })
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
