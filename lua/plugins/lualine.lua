-- Lualine configuration

local non_language_ft = {'fugitive', 'startify'}

require('lualine').setup({
  options = {
    -- Separators might look weird for certain fonts (eg Cascadia)
    component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {
    {
      'filename',
      file_status = true,      -- Displays file status (readonly status, modified status)
      newfile_status = false,   -- Display new file status (new file means no write after created)
      path = 1,                -- 0: Just the filename
                               -- 1: Relative path
                               -- 2: Absolute path
                               -- 3: Absolute path, with tilde as the home directory

      shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                               -- for other components. (terrible name, any suggestions?)
      symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for new created file before first writting
      }
    }
  },
    lualine_x = {
      'filetype',
      {
        function()
          local msg = 'No LSP'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()

          if next(clients) == nil  then
            return msg
          end

          -- Check for utility buffers
          for ft in non_language_ft do
            if ft:match(buf_ft) then
              return ''
            end
          end

          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes

            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              -- return 'LSP:'..client.name  -- Return LSP name
              return ''  -- Only display if no LSP is found
            end
          end

          return msg
        end,
        color = {fg = '#ffffff', gui = 'bold'},
        separator = "",
      },
      {
        'diagnostics',
        sources = {'nvim_diagnostic'},
        sections = {'error', 'warn', 'info'},
      },
    },
    lualine_y = {'progress'},
    lualine_z = {
      {function () return '' end},
      {'location'},
    }
  },
})
