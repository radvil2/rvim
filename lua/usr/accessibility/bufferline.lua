local M = {}
local env = Env.editor.bufferline

M.id = "akinsho/nvim-bufferline.lua"

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.keys = {
  {
    "<Leader>bP",
    "<Cmd>BufferLineTogglePin<CR>",
    desc = "Pin/unpin buffer",
  },
  {
    "<A-b>",
    "<Cmd>BufferLinePick<CR>",
    desc = "Pick buffer",
  },
  {
    "<A-[>",
    "<Cmd>BufferLineMovePrev<CR>",
    desc = "Move buffer to left",
  },
  {
    "<A-]>",
    "<Cmd>BufferLineMoveNext<CR>",
    desc = "Move buffer to right",
  },
  {
    "<A-,>",
    "<Cmd>BufferLineCyclePrev<CR>",
    desc = "Switch to prev buffer",
  },
  {
    "<A-.>",
    "<Cmd>BufferLineCycleNext<CR>",
    desc = "Switch to next buffer",
  },
  {
    "<A-1>",
    "<Cmd>BufferLineGoToBuffer 1<CR>",
    desc = "Switch to 1st buffer",
  },
  {
    "<A-2>",
    "<Cmd>BufferLineGoToBuffer 2<CR>",
    desc = "Switch to 2nd buffer",
  },
  {
    "<A-3>",
    "<Cmd>BufferLineGoToBuffer 3<CR>",
    desc = "Switch to 3rd buffer",
  },
  {
    "<A-4>",
    "<Cmd>BufferLineGoToBuffer 4<CR>",
    desc = "Switch to 5th buffer",
  },
  {
    "<A-5>",
    "<Cmd>BufferLineGoToBuffer 5<CR>",
    desc = "Switch to 5th buffer",
  },
}

M.opts = {
  options = {
    diagnostics = "nvim_lsp",
    indicator = { style = "icon" },
    always_show_bufferline = false,
    separator_style = env.style or "slant",
    show_close_icon = env.show_buffer_close or false,
    show_tab_indicators = env.show_indicators or false,
    diagnostics_indicator = function(_, _, diag)
      local icons = require("media.icons").Diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        text = require("media.icons").Misc.Vim .. " File Explorer",
        highlight = "Directory",
        filetype = "NvimTree",
        text_align = "left",
      },
    },
  },
}

M.repo = {
  M.id,
  event = "VeryLazy",
  dependencies = M.dependencies,
  enabled = env.enable,
  keys = M.keys,
  opts = M.opts,
}

return M
