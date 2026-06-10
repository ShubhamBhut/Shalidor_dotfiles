return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  -- Forces cargo to compile the templates locally so the error never returns
  build = "make BUILD_FROM_SOURCE=true", 
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    -- The magic dependency that makes the chat look beautiful
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function()
    require("avante").setup({
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          -- Bulletproof API key loading. Never prompts you again.
          api_key_name = "cmd:cat ~/.openrouter_key",
          model = "moonshotai/kimi-k2.6:free",
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
      },
      windows = {
        position = "right",
        width = 40, -- Shrunk down from 80 to form a clean, non-intrusive sidebar
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8,
        },
        ask = {
          floating = false, -- Kills the tiny hover popup
          start_insert = true,
          focus_on_apply = "ours",
        },
      },
      hints = {
        enabled = true,
      },
    })

    -- Toggle the beautifully formatted sidebar on and off
    vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<CR>", {
      noremap = true,
      silent = true,
      desc = "Toggle Avante window",
    })
  end,
}
