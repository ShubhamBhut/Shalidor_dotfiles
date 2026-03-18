return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    -- 1. Elegant Rosé Pine Palette
    local colors = {
      base    = '#191724',
      surface = '#1f1d2e',
      overlay = '#26233a',
      text    = '#e0def4',
      love    = '#eb6f92',
      gold    = '#f6c177',
      rose    = '#ea9a97',
      pine    = '#31748f',
      foam    = '#9ccfd8',
      iris    = '#c4a7e7',
    }

    -- 2. Bubbles Theme
    local bubbles_theme = {
      normal = {
        a = { fg = colors.base, bg = colors.iris, gui = 'bold' },
        b = { fg = colors.text, bg = colors.surface },
        c = { fg = colors.text, bg = colors.base },
      },
      insert  = { a = { fg = colors.base, bg = colors.foam, gui = 'bold' } },
      visual  = { a = { fg = colors.base, bg = colors.rose, gui = 'bold' } },
      replace = { a = { fg = colors.base, bg = colors.love, gui = 'bold' } },
      command = { a = { fg = colors.base, bg = colors.gold, gui = 'bold' } },
      inactive = {
        a = { fg = colors.text, bg = colors.overlay },
        b = { fg = colors.text, bg = colors.overlay },
        c = { fg = colors.text, bg = colors.base },
      },
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
    }

    local function custom_lsp()
      local msg = 'No LSP'
      local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then return msg end
      
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end

    -- 3. Toggle Statusline Keymap
    -- This binds `<leader>tl` (Toggle Lualine) to hide/show the bar
    vim.keymap.set('n', '<leader>tl', function()
      if vim.opt.laststatus:get() == 0 then
        vim.opt.laststatus = 3 -- Show global statusline
      else
        vim.opt.laststatus = 0 -- Hide statusline entirely
      end
    end, { desc = 'Toggle Lualine visibility' })

    -- 4. Setup Lualine (Compacted)
    lualine.setup {
      options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 
          -- Reduced right padding from 2 to 1 for a tighter bubble
          { 'mode', separator = { left = '' }, right_padding = 1 } 
        },
        lualine_b = { 
          { 'branch', icon = '', padding = 1 }, 
          { 
            'diff',
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
              added = { fg = colors.pine },
              modified = { fg = colors.gold },
              removed = { fg = colors.love },
            },
            cond = conditions.hide_in_width,
            padding = 0, -- Removed padding between git and diff
          },
        },
        lualine_c = {
          {
            'filename',
            cond = conditions.buffer_not_empty,
            color = { fg = colors.iris, gui = 'bold' },
            padding = 1,
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
              error = { fg = colors.love },
              warn = { fg = colors.gold },
              info = { fg = colors.foam },
            },
          },
          '%=',
          {
            custom_lsp,
            icon = ' ', -- Removed "LSP:" text to save space
            color = { fg = colors.foam, gui = 'bold' },
          },
        },
        lualine_x = {
          {
            'filesize',
            cond = conditions.buffer_not_empty,
            padding = 1,
          },
        },
        lualine_y = { 
          { 'progress', padding = 1 } 
        },
        lualine_z = {
          -- Reduced left padding from 2 to 1
          { 'location', separator = { right = '' }, left_padding = 1 },
        },
      },
      inactive_sections = {
        lualine_a = { { 'filename', separator = { left = '' } } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { 'location', separator = { right = '' } } },
      },
    }
  end
}
