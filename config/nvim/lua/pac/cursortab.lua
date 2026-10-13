local base = {
  enabled = true,
  log_level = "info",
  state_dir = vim.fn.stdpath "state" .. "/cursortab",
  contribute_data = false,

  keymaps = {
    accept = "<C-y>",
    partial_accept = "<S-Tab>",
    trigger = "<A-t>",
  },

  ui = {
    completions = {
      addition_style = "dimmed",
      fg_opacity = 0.6,
    },
    jump = {
      symbol = "",
      text = " TAB ",
      show_distance = true,
    },
  },

  behavior = {
    idle_completion_delay = 50,
    text_change_debounce = 50,
    -- idle_completion_delay = -1,
    -- text_change_debounce = -1,
    max_visible_lines = 15,
    disabled_in = {},
    enabled_modes = { "insert", "normal" },
    cursor_prediction = {
      enabled = true,
      auto_advance = false,
      proximity_threshold = 2,
    },
    ignore_filetypes = { "", "terminal" },
  },

  provider = {
    api_key_env = "",
    temperature = 0.0,
    top_k = 50,
    completion_timeout = 10000,
    completion_path = "/v1/completions",
    privacy_mode = true,
  },

  blink = {
    enabled = false,
    ghost_text = true,
  },

  debug = {
    immediate_shutdown = false,
  },
}

local profiles = {
  inline = {
    type = "inline",
    url = "http://localhost:8101",
    model = "ggml-org/Qwen3.5-0.8B-GGUF:Q8_0",
    max_tokens = 64,
    context_size = 1024,
    max_diff_history_tokens = 512,
  },
  sweep = {
    type = "sweep",
    url = "http://localhost:8102",
    model = "sweepai/sweep-next-edit-1.5B:V2",
    max_tokens = 512,
    context_size = 0,
    max_diff_history_tokens = 512,
  },
}

local current = "inline"

local function use(name)
  local p = profiles[name]
  require("cursortab").setup(vim.tbl_deep_extend("force", base, {
    provider = {
      type = p.type,
      url = p.url,
      model = p.model,
      max_tokens = p.max_tokens,
      context_size = p.context_size,
      max_diff_history_tokens = p.max_diff_history_tokens,
    },
  }))
  current = name
  vim.notify("cursortab: " .. name)
end

use "inline"

vim.api.nvim_create_user_command("ToggleInlineModel", function()
  use(current == "inline" and "sweep" or "inline")
end, {})

vim.keymap.set("n", "<leader>ct", "<cmd>ToggleInlineModel<cr>", { desc = "cursortab: toggle inline/sweep" })
