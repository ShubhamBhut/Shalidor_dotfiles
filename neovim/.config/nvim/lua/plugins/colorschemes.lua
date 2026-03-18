vim.cmd [[autocmd FileType * set formatoptions-=o]]
return {
    {
        "fffnite/gleam-theme-nvim",
    },
    {
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
    end
    },
    {
        "vague-theme/vague.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            -- NOTE: you do not need to call setup if you don't want to.
            require("vague").setup({
            -- optional configuration here
            })
            vim.cmd("colorscheme vague")
        end
    },
    {
        "ellisonleao/gruvbox.nvim", priority = 1000,
        opts = {},
    },
    {
        "mcchrish/zenbones.nvim",
        requires = 'rktjmp/lush.nvim',
    },
    {
        'rktjmp/lush.nvim',
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {},
    },
    {
        'rose-pine/neovim', name = 'rose-pine',
        opts = {},
    }
}
