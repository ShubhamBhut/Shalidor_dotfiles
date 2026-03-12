return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
  opts = {
    keymap = { 
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
    },
    snippets = {
      preset = 'luasnip',
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "codecompanion" },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
        },
      },
    },
    -- appearance MUST be a peer to sources, not inside it
    appearance = {
      nerd_font_variant = 'mono',
    },
  }, -- Closes 'opts'
} -- Closes 'return'. NO EXTRA BRACES.
