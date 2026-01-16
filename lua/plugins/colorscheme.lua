return {
  {
    "jesseleite/nvim-noirbuddy",
    lazy = false,
    priority = 1000,
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      require("noirbuddy").setup({
        preset = "minimal",
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "noirbuddy",
    },
  },
}
