return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"
      configs.setup {
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "elixir",
          "javascript",
          "html",
          "python",
          "typescript",
          "go",
          "yaml",
          "toml",
          "java",
          "css",
          "sql",
        },
        sync_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "mbbill/undotree",
  },
  {
    "f-person/auto-dark-mode.nvim",
    event = "VeryLazy",
    config = function()
      local config = require "nvconfig"
      require("auto-dark-mode").setup {
        update_interval = 1000,
        set_dark_mode = function()
          if config.base46.theme ~= "rosepine" then
            config.base46.theme = "rosepine"
            require("base46").load_all_highlights()
            print "Switched to dark theme"
          end
        end,
        set_light_mode = function()
          if config.base46.theme ~= "rosepine-dawn" then
            config.base46.theme = "rosepine-dawn"
            require("base46").load_all_highlights()
            print "Switched to light theme"
          end
        end,
      }

      require("auto-dark-mode").init()
    end,
  },
}
