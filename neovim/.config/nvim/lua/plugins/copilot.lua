return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = false, -- We disable the split panel in favor of inline suggestions
      },
      suggestion = {
        enabled = true,
        auto_trigger = true, -- This makes the "ghost text" appear automatically as you type
        debounce = 75,       -- Prevents API spamting while you type fast
        keymap = {
          accept = "<Tab>",          -- Accept the full suggestion
          accept_word = "<C-Right>", -- Accept only the next word
          accept_line = "<C-Down>",  -- Accept only the next line
          next = "<M-]>",            -- Cycle to the next suggestion (Alt + ])
          prev = "<M-[>",            -- Cycle to the previous suggestion (Alt + [)
          dismiss = "<C-]>",         -- Clear the suggestion from your screen
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        ["."] = false,
      },
      copilot_node_command = 'node',
      server_opts_overrides = {},
    })
  end,
}
