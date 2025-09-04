-- lua/custom/plugins/ruby_lsp.lua
return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Start Ruby LSP via bundler to match your project’s version
      lspconfig.ruby_lsp.setup {
        cmd = { 'bundle', 'exec', 'ruby-lsp' },
        on_attach = function(_, bufnr)
          -- Minimal keymaps so you have gd/hover even if Kickstart didn’t apply buffer maps yet
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
          end
          map('n', 'gd', vim.lsp.buf.definition)
          map('n', 'gr', vim.lsp.buf.references)
          map('n', 'K', vim.lsp.buf.hover)
        end,
      }
    end,
  },
}
