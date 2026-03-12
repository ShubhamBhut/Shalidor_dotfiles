return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = { api_key = "GEMINI_API_KEY" },
            schema = {
              model = { default = "gemini-3-flash" },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
        agent = { adapter = "gemini" },
      },
      -- PROFILES: "Startup CTO" and "Data Scientist" tools
      prompt_library = {
        ["Data Scientist"] = {
          strategy = "chat",
          description = "Expert in Python, ANOVA, and ML logic",
          opts = { is_slash_cmd = true },
          prompts = {
            {
              role = "system",
              content = "You are a senior Data Scientist and former veteren ptyhon developer. Prioritize clean, vectorized Python code."
            },
          },
        },
      },
    })

    -- Keymaps: Use <leader>c for Companion to avoid Avante conflict
    vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Context" })
  end,
}
