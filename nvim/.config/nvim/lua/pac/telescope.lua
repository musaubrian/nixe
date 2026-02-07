vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    local telescope = require "telescope"

    telescope.setup {
      defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = {
          prompt_position = "top",
          height = 0.9,
          width = 0.95,
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    }

    require "pac.telescope.fine_grep"

    local builtin = require "telescope.builtin"
    local action = require "telescope.actions"

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files {
        cwd = vim.fn.stdpath "config",
      }
    end, { desc = "[S]earch [N]eovim files" })

    vim.keymap.set("n", "<leader>ss", function()
      builtin.find_files {
        cwd = "~/.local/bin/scripts/",
      }
    end, { desc = "[S]earch [S]cripts" })

    vim.keymap.set("n", "<leader>nc", function()
      builtin.find_files {
        cwd = "~/personal/nixe",
      }
    end, { desc = "[N]ix [C]onfig" })

    vim.keymap.set("n", "<leader><space>", builtin.oldfiles, { desc = "Recently opened files" })
    vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })

    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })

    vim.keymap.set("n", "<leader>wk", builtin.keymaps, { desc = "Available keybinds [W]hich [K]ey" })

    vim.keymap.set("n", "C-q", function()
      action.smart_send_to_qflist()
      vim.cmd "copen"
    end, { desc = "Send items to quick fix list" })
  end,
  once = true,
})
