return {
  --Language servers and install mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  -- Nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      --Lua Configaration
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      --C/C++ Configaration
      lspconfig.clangd.setup({
        capabilities = capabilities
      })
      --Nix Configaration
      lspconfig.nil_ls.setup({
        capabilities = capabilities
      })

      --keybinds
      vim.keymap.set({ 'n' }, '<leader>ea', vim.lsp.buf.code_action, {})
    end
  }
}
