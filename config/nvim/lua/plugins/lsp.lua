return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { "j-hui/fidget.nvim", event = "BufEnter", opts = {} },
    { "saghen/blink.cmp" },
  },
  opts = {
    servers = {
      zls = {},
      lua_ls = {},
      gopls = {},
      pylsp = {},
      marksman = {},
      templ = {},
      phpactor = {},
      tailwindcss = {},
      rust_analyzer = {},
      nil_ls = {},
      tinymist = {
        settings = {
          semanticTokens = "disable",
        },
      },
      volar = {
        filetypes = { "vue" },
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
      ts_ls = {
        server_capabilities = {
          documentFormattingProvider = false,
        },
      },
    },
  },

  config = function(_, opts)
    local lspconfig = require "lspconfig"
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
