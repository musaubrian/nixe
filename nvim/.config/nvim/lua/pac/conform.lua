vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    local conform = require "conform"

    conform.setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },

      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        svelte = { "oxfmt" },
        json = { "oxfmt" },
        jsonc = { "oxfmt" },
        vue = { "oxfmt" },
        html = { "oxfmt" },
        css = { "oxfmt" },
        go = { "goimports" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        typst = { "typstyle" },
      },
    }
  end,
  once = true,
})
