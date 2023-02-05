local M = {}

local env = Env.theme
local flavour = env.colorvariant or "mocha"
local transbg = env.transparentbg

if not env.darkmode then
  flavour = "latte"
  transbg = false
end

M.opts = function()
  local opts = {
    transparent_background = transbg,
    term_colors = true,
    dim_inactive = {
      percentage = 0.15,
      enabled = true,
      shade = "dark",
    },
    background = {
      light = "latte",
      dark = "mocha",
    },
    styles = {
      conditionals = { "italic" },
      comments = { "italic" },
    },
    integrations = {
      treesitter = true,
      coc_nvim = false,
      lsp_trouble = true,
      cmp = true,
      lsp_saga = true,
      leap = true, -- test
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      which_key = true,
      dashboard = true,
      neogit = false,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = true,
      hop = true,
      notify = true,
      telekasten = false,
      symbols_outline = false,
      mini = true,
      navic = false,
      neotree = true,
      noice = true,
      fidget = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = transbg,
      },
      dap = {
        enabled = false,
        enable_ui = false,
      },
      indent_blankline = {
        colored_indent_levels = false,
        enabled = true,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          information = { "italic" },
          warnings = { "italic" },
          errors = { "italic" },
          hints = { "italic" },
        },
        underlines = {
          information = { "underline" },
          warnings = { "underline" },
          errors = { "underline" },
          hints = { "underline" },
        },
      },
    },
  }

  if transbg then
    local colors = require("catppuccin.palettes").get_palette()
    local user_colors = require("media.colors").palette

    colors.none = "NONE"

    -- opts.custom_highlights = {
    --   Comment = {
    --     fg = colors.overlay1,
    --   },
    --   LineNr = {
    --     fg = colors.overlay1,
    --   },
    --   DiagnosticVirtualTextError = {
    --     bg = colors.none,
    --     fg = user_colors.red,
    --   },
    --   DiagnosticVirtualTextWarn = {
    --     bg = colors.none,
    --     fg = user_colors.yellow,
    --   },
    --   DiagnosticVirtualTextInfo = {
    --     bg = colors.none,
    --   },
    --   DiagnosticVirtualTextHint = {
    --     bg = colors.none,
    --   },
    -- }

    if flavour == "mocha" then
      opts.custom_highlights = Merge(opts.custom_highlights, {
        TelescopeBorder = {
          fg = user_colors.yellow,
        },
        BufferLineErrorSelected = {
          fg = user_colors.red,
          bold = true,
        },
        BufferLineWarningSelected = {
          fg = user_colors.yellow,
          bold = true,
        },
        BufferLineInfoSelected = {
          fg = user_colors.cyan,
          bold = true,
        },
        NvimTreePopup = {
          fg = user_colors.yellow,
        },
        NvimTreeFolderIcon = {
          fg = user_colors.yellow,
        },
        NvimTreeFolderName = {
          fg = user_colors.fg,
        },
        NavicText = {
          fg = user_colors.cyan,
        },
        NavicSeparator = {
          fg = "#8087A2",
        },
      })
    end
  end

  return opts
end

---@type LazySpec
M.repo = {
  "catppuccin/nvim",
  name = "catppuccin",
  -- lazy = env.colorscheme ~= "catppuccin",
  event = "VeryLazy",
  opts = M.opts,
  init = function()
    if env.colorscheme == "catppuccin" then
      vim.g.catppuccin_flavour = flavour
      vim.cmd("colorscheme catppuccin")
    end
  end,
}

return M
