local M = {}

M.id = "sindrets/winshift.nvim"

M.keys = {
  {
    "<C-w><C-m>",
    "<Cmd>WinShift<CR>",
    desc = "[Window] Enter shift mode",
  },
  {
    "<C-w>m",
    "<Cmd>WinShift<CR>",
    desc = "[Window] Enter shift mode",
  },
  {
    "<C-w><Cr>",
    "<Cmd>WinShift swap<CR>",
    desc = "[Window] Swap windows",
  },
  {
    "<C-w>j",
    "<Cmd>WinShift down<CR>",
    desc = "[Window] Shift down",
  },
  {
    "<C-w>k",
    "<Cmd>WinShift top<CR>",
    desc = "[Window] Shift top",
  },
  {
    "<C-w>h",
    "<Cmd>WinShift left<CR>",
    desc = "[Window] Shift left",
  },
  {
    "<C-w>l",
    "<Cmd>WinShift right<CR>",
    desc = "[Window] Shift right",
  },
}

M.opts = function()
  local picker = require("winshift.lib").pick_window
  return {
    highlight_moving_win = true,
    focused_hl_group = "Visual",
    keymaps = {
      disable_defaults = false,
      win_move_mode = {
        ["h"] = "left",
        ["H"] = "far_left",
        ["j"] = "down",
        ["J"] = "far_down",
        ["k"] = "up",
        ["K"] = "far_up",
        ["l"] = "right",
        ["L"] = "far_right",
      },
    },
    window_picker = function()
      return picker({
        picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        filter_rules = {
          cur_win = true,
          floats = true,
          filetype = require("opt.filetype").excludes,
        },
      })
    end,
  }
end

M.repo = {
  M.id,
  opts = M.opts,
  keys = M.keys,
  event = "VeryLazy",
  cmd = "WinShift",
}

return M
