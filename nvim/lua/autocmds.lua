require "nvchad.autocmds"

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>zz", opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>zz", opts)
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>zz", opts)
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>zz", opts)
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set({ "n", "x" }, "gF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "gEx", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = event.data.client_id }
      end,
    })
  end,
})
