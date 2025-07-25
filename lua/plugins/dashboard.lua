return {
  {
    'nvimdev/dashboard-nvim',
    opts = function()
      --stylua: ignore
      local logo = [[
╭───────────────────────────────────────────────────────────────────────────╮
│                                                                           │
│  `7MN.   `7MF'`7MM"""YMM    .g8""8q.`7MMF'   `7MF'`7MMF'`7MMM.     ,MMF'  │
│    MMN.    M    MM    `7  .dP'    `YM.`MA     ,V    MM    MMMb    dPMM    │
│    M YMb   M    MM   d    dM'      `MM VM:   ,V     MM    M YM   ,M MM    │
│    M  `MN. M    MMmmMM    MM        MM  MM.  M'     MM    M  Mb  M' MM    │
│    M   `MM.M    MM   Y  , MM.      ,MP  `MM A'      MM    M  YM.P'  MM    │
│    M     YMM    MM     ,M `Mb.    ,dP'   :MM;       MM    M  `YM'   MM    │
│  .JML.    YM  .JMMmmmmMMM   `"bmmd"'      VF      .JMML..JML. `'  .JMML.  │
│                                                                           │
╰───────────────────────────────────────────────────────────────────────────╯
      ]]
      logo = string.rep('\n', 8) .. logo .. '\n\n'
      local builtin = require 'telescope.builtin'
      local browser = require('telescope').extensions.file_browser
      local live_grep = require('telescope').extensions.live_grep_args
      local opts = {
        theme = 'doom',
        config = {
          header = vim.split(logo, '\n'),
          center = {
            {
              action = builtin.find_files,
              desc = ' Search files',
              icon = ' ',
              key = 's',
            },
            {
              action = browser.file_browser,
              desc = ' Browse files',
              icon = '󰈙 ',
              key = 'e',
            },
            -- {
            --   action = 'ene | startinsert',
            --   desc = ' New file',
            --   icon = ' ',
            --   key = 'n',
            -- },
            {
              action = builtin.oldfiles,
              desc = ' Recent files',
              icon = ' ',
              key = 'r',
            },
            {
              action = live_grep.live_grep_args,
              desc = ' Find text',
              icon = ' ',
              key = 'f',
            },
            {
              action = 'Neogit',
              desc = ' Git status',
              icon = '󰊢 ',
              key = 'd',
            },
            {
              action = 'Lazy',
              desc = ' Lazy',
              icon = '󰒲 ',
              key = 'l',
            },
            {
              action = function()
                vim.api.nvim_input '<cmd>qa<cr>'
              end,
              desc = ' Quit',
              icon = ' ',
              key = 'q',
            },
          },
          footer = {},
        },
      }
      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 21 - #button.desc)
        button.key_format = '  %s'
      end
      if vim.o.filetype == 'lazy' then
        vim.api.nvim_create_autocmd('WinClosed', {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
            end)
          end,
        })
      end
      return opts
    end,
  },
}
