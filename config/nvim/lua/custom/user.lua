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
  vim.cmd "split |term"
end, { desc = "Open terminal in split mode at the bottom" })

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
}

vim.api.nvim_create_user_command("Todo", function()
  local query = vim.fn.input "What to do > "
  vim.fn.system(string.format("python3 ~/scripts/gg.py -it '%s'", query))
end, {})

vim.api.nvim_create_user_command("Idea", function()
  local query = vim.fn.input "What ya thinking > "
  vim.fn.system(string.format("python3 ~/scripts/gg.py -id '%s'", query))
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- does this work without blink, will see
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
    end

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

vim.filetype.add {
  extension = {
    templ = "templ",
  },
}
