-- ayu dark / ayu light, following the terminal background.
-- Neovim detects the terminal background at startup and sets 'background';
-- the "ayu" colorscheme picks its dark or light variant from it, and
-- changing 'background' later reloads the colorscheme automatically.
return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({ mirage = false }) -- dark variant = ayu-dark, not ayu-mirage
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ayu",
    },
  },
}
