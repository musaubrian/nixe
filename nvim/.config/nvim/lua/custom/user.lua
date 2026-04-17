local me_group = vim.api.nvim_create_augroup("MeGroup", { clear = true })
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- [[ Highlight on yank ]]
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--[[ Remove whitespaces at line ends ]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = me_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Make term more usable
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = me_group,
  pattern = "*",
  callback = function()
    vim.cmd.setlocal "norelativenumber"
    vim.cmd.setlocal "nonumber"
    vim.cmd.setlocal "norelativenumber"
    vim.cmd.setlocal "signcolumn=no"
    vim.cmd.setlocal "nocursorline"
    vim.cmd "tnoremap <buffer> <Esc> <C-\\><C-n>"
    vim.cmd "startinsert"
    vim.cmd "nnoremap <buffer> <C-c> i<C-c>"
    vim.cmd "nnoremap <buffer> <C-d> iexit<CR>"
  end,
})

vim.api.nvim_create_user_command("GenId", function()
  local c = require "custom.common"
  local id = c.GenId()
  if not id or id == "" then
    vim.notify("[GenId] Failed to gen id, bailing", vim.log.levels.ERROR)
    return
  end

  vim.fn.setreg("+", id, "c")
  vim.notify "Copied to clipboard"
end, { desc = "Generate an id" })

vim.api.nvim_create_autocmd({ "TermClose" }, {
  group = me_group,
  pattern = "*",
  callback = function()
    -- reset splitbelow
    vim.opt.splitbelow = false
  end,
})

-- Open terminal in split view at the bottom
vim.api.nvim_create_user_command("Term", function()
  vim.cmd.setlocal "splitbelow"
  vim.cmd "18split |term"
end, { desc = "Open terminal in split mode at the bottom" })

vim.api.nvim_create_user_command("FTerm", function()
  vim.cmd "term"
end, { desc = "Open terminal in *full screen mode" })

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
      return
    end

    -- Kill tsgo when we also have deno's lsp running
    -- means we are in a deno project and tsgo will just eat up ram
    -- for nothing
    -- The delay is for tsgo to attach and startup
    vim.defer_fn(function()
      local deno_clients = vim.lsp.get_clients { name = "deno" }
      local typescript_clients = vim.lsp.get_clients { name = "typescript" }
      if #deno_clients > 0 and #typescript_clients > 0 then
        typescript_clients[1]:stop()
        vim.notify "[LSP] Disabled typescript lsp, preferring deno"
      end
    end, 500)

    if client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
    end

    vim.api.nvim_create_user_command("LspInfo", function()
      vim.cmd "checkhealth vim.lsp"
    end, {})

    vim.api.nvim_create_user_command("LspRestart", function()
      client:stop()
      vim.lsp.start(client.config, {})
    end, {})

    vim.api.nvim_create_user_command("LspStop", function()
      client:stop(1)
    end, {})

    vim.api.nvim_create_user_command("LspStart", function()
      vim.lsp.start(client.config, {})
    end, {})

    local nmap = function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end

    nmap("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]o to [R]eference")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>gD", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("<leader>rn", vim.lsp.buf.rename)
    nmap("<leader>ca", vim.lsp.buf.code_action)

    -- its kinda neat
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "signature help" })
  end,
})

vim.cmd [[
  let g:did_install_default_menus = 1
  let g:loaded_netrwPlugin = 0
  let g:loaded_python3_provider = 0

  aunmenu PopUp
  autocmd! nvim.popupmenu
]]

vim.cmd "syntax off"

vim.api.nvim_create_user_command("PackClean", function()
  local active_plugins = {}
  local inactive_plugins = {}

  for _, plugin in ipairs(vim.pack.get()) do
    active_plugins[plugin.spec.name] = plugin.active
  end

  for _, plugin in ipairs(vim.pack.get()) do
    if not active_plugins[plugin.spec.name] then
      table.insert(inactive_plugins, plugin.spec.name)
    end
  end

  if #inactive_plugins == 0 then
    vim.notify("No unused plugins", vim.log.levels.INFO)
    return
  end

  local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(inactive_plugins)
  end
end, { desc = "Remove unused plugins" })

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, { desc = "Update plugins" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "odin",
  callback = function()
    vim.opt_local.errorformat = "%f(%l:%c) %m, %-G%.%#"
    vim.opt_local.makeprg = "./first.bin"
  end,
})

vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
