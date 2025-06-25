return {
  "tpope/vim-fugitive",
  "wakatime/vim-wakatime",
  "junegunn/vim-easy-align",
  "norcalli/nvim-colorizer.lua",
  "tpope/vim-sleuth",
  "mbbill/undotree",
  "musaubrian/scratch.nvim",

  { "musaubrian/minline.nvim", opts = {} },
  { "j-hui/fidget.nvim", event = "BufEnter", opts = {} },
  { "stevearc/dressing.nvim", event = "BufEnter", opts = {} },
  { "lewis6991/gitsigns.nvim", lazy = true, event = "BufEnter", opts = {} },
  {
    "musaubrian/jade.nvim",
    lazy = false,
    dependencies = "tjdevries/colorbuddy.nvim",
    opts = { no_bg = true },
  },
  {
    "musaubrian/pye.nvim",
    event = "BufEnter",
    opts = {
      base_venv = "~/.base_vnv",
    },
  },
}
