vim.diagnostic.config { signs = false }
return {
   {
      "williamboman/mason.nvim",
      config = function()
         require("mason").setup()
      end
   },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
         require("mason-lspconfig").setup()
      end
   },
   {
      'dcampos/nvim-snippy',
   },
   {
      'gleam-lang/gleam.vim'
   },
   {
      'neovim/nvim-lspconfig',
      keys = {
         { 'xx',       vim.lsp.buf.code_action,                           mode = { 'n', 'x' } },
         { 'xf',       vim.lsp.buf.format },
         { 'xr',       vim.lsp.buf.rename },
         { 'gd',       vim.lsp.buf.definition },
         { 'gt',       vim.lsp.buf.type_definition },
         { '<space>d', vim.lsp.buf.hover },
         { 'gi',       '<cmd>Telescope lsp_implementations<cr>' },
         { 'gr',       '<cmd>Telescope lsp_references<cr>' },
         { 'g<space>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
      },
      event = "BufEnter",
      config = function()
         local function setup_server(name, opts)
            opts = opts or {}
            vim.lsp.config(name, opts) -- Define the config
            vim.lsp.enable(name)       -- Start the server
         end

         -- Configure your servers here
         setup_server('pyright', { single_file_support = true })
         setup_server('clangd', { single_file_support = true })
         setup_server('ts_ls', { single_file_support = true })
         setup_server('lua_ls', { single_file_support = true })
         setup_server('gopls', { single_file_support = true })
         
         -- Servers with default settings
         local default_servers = { 
            'rust_analyzer', 'eslint', 'emmet_ls', 'ols', 
            'yamlls', 'solidity_ls', 'html', 'svelte', 
            'julials', 'ocamllsp', 'gleam', 'gdscript' 
         }

         for _, server in ipairs(default_servers) do
            setup_server(server)
         end
      end,
   },
   {
      'simrat39/rust-tools.nvim',
      event = "BufReadPre *.rs",
      enabled = true,
      keys = {
         { 'pm', function() require('rust-tools').parent_module.parent_module() end }
      },
      config = function()
         local caps = require('cmp_nvim_lsp').default_capabilities()
         require('rust-tools').setup {
            tools = {
               inlay_hints = {
                  auto = false,
               },
            },
            server = {
               -- cmd = { 'nc', 'localhost', '6969' },
               root_dir = function(fname)
                  local util = require 'lspconfig.util'
                  return util.root_pattern 'Cargo.lock' (fname)
                     or util.root_pattern 'Cargo.toml' (fname)
                     or util.root_pattern 'rust-project.json' (fname)
                     or util.find_git_ancestor(fname)
               end,
               capabilities = caps,
               standalone = false,
            },
         }
      end,
   },
   {
      'Maan2003/lsp_lines.nvim',
      enabled = true,
      event = "LspAttach",
      keys = {
         {
            'xe',
            function()
               local old = vim.diagnostic.config().virtual_lines
               if old then
                  vim.diagnostic.config {
                     virtual_text = true,
                     underline = {
                        severity = { min = vim.diagnostic.severity.WARN }
                     },
                     virtual_lines = false,
                  }
               else
                  vim.diagnostic.config {
                     virtual_text = false,
                     underline = true,
                     virtual_lines = true,
                  }
               end
            end,
         },
      },
      config = function()
         require('lsp_lines').setup()
         vim.diagnostic.config {
            virtual_text = true,
            underline = {
               severity = { min = vim.diagnostic.severity.WARN }
            },
            virtual_lines = false,
         }
      end,
   },
}
