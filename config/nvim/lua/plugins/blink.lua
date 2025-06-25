return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<A-CR>"] = { "select_and_accept" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        path = {
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
    completion = {
      menu = {
        auto_show = function()
          -- Dont show on command mode
          if vim.fn.mode() == "c" or vim.fn.mode() == "i" then
            return false
          end
          return true
        end,
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },
    },
  },
}
