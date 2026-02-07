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
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        svelte = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        vue = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        go = { "goimports" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        typst = { "typstyle" },
        odin = { "odinfmt" },
      },
    }
  end,
  once = true,
})
