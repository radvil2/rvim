local icons = require("media.icons")
local palette = require("media.colors").palette
local utils = require("usr.ui.lualine.utils")
local theme = Env.theme.colorscheme
local env = Env.editor.statusline

return {
  options = {
    disabled_filetypes = env.disabled_filetypes,
    globalstatus = env.is_global or false,
    component_separators = {
      left = "",
      right = "",
    },
    section_separators = {
      left = "",
      right = "",
    },
    always_divide_middle = true,
    icons_enabled = true,
    ignore_focus = {},
    theme = theme,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {
      "fileformat",
      "mode",
    },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "filetype",
        fmt = function(ftype)
          local fsize = utils.get_filesize()
          local fname = utils.get_filename()
          return ftype .. fsize .. fname
        end,
      },
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = icons.Diagnostics.Error,
          warn = icons.Diagnostics.Warn,
          info = icons.Diagnostics.Info,
          hint = icons.Diagnostics.Hint,
        },
        diagnostics_color = {
          color_error = {
            fg = palette.red,
          },
          color_warn = {
            fg = palette.yellow,
          },
          color_info = {
            fg = palette.cyan,
          },
        },
      },
    },
    lualine_x = {
      {
        "lsp_progress",
        spinner_symbols = icons.SpinnerFrames,
        display_components = {
          "lsp_client_name",
          "spinner",
        },
        color = {
          bg = palette.trans,
          fg = palette.yellow,
        },
      },
      {
        "diff",
        cond = IsGitWorkspace,
        symbols = {
          added = icons.Git.Untracked .. " ",
          modified = icons.Git.Unstaged .. " ",
          removed = icons.Git.Deleted .. " ",
        },
        diff_color = {
          added = {
            fg = palette.green,
          },
          modified = {
            fg = palette.yellow,
          },
          removed = {
            fg = palette.red,
          },
        },
      },
      {
        function()
          return utils.get_server_names()
        end,
        fmt = function(servername)
          return servername .. " 👻"
        end,
      },
    },
    lualine_y = {
      {
        "progress",
        fmt = function(progress)
          return progress .. " 🚀"
        end,
      },
    },
    lualine_z = {
      {
        "location",
        fmt = function(location)
          return location .. " 🐧"
        end,
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      "filename",
    },
    lualine_x = {
      "location",
    },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
