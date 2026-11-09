-- Extra gopls settings on top of LazyVim's lang.go extra.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              -- include files behind these build tags (e.g. SCBL API e2e tests),
              -- otherwise gopls reports "no package metadata" and has no definitions
              buildFlags = { "-tags=e2e_tests" },
            },
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- discover testify suite methods (s.Run subtests, TestXxxSuite runners)
          testify_enabled = true,
        },
      },
    },
  },
}
