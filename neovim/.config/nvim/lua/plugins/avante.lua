return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make BUILD_FROM_SOURCE=true", 
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
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
      providers = {
      gemini = {
        model = "gemma-4-31b-it",
        -- temperature = 0,
        -- max_tokens = 4096,
      },
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "poolside/laguna-m.1:free",
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
        width = 40,
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
          floating = false,
          start_insert = true,
          focus_on_apply = "ours",
        },
      },
      hints = {
        enabled = true,
      },
    })

    vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<CR>", { noremap = true, silent = true, desc = "Toggle Avante window" })
    vim.keymap.set("n", "<leader>as", function() vim.cmd("AvanteSwitchProvider") end, { noremap = true, silent = true, desc = "Switch Avante Provider" })
  end,
}
