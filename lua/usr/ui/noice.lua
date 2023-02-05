-- @desc: noicer UI
local M = {}

M.api = {
  redirect_cmd = function()
    require("noice").redirect(vim.fn.getcmdline())
  end,

  noice_last_message = function()
    require("noice").cmd("last")
  end,

  noice_history = function()
    require("noice").cmd("history")
  end,

  noice_all = function()
    require("noice").cmd("all")
  end,

  -- noice_lsp_scrollforward = function()
  --   if not require("noice.lsp").scroll(4) then
  --     return "<C-f>"
  --   end
  -- end,

  -- noice_lsp_scrollbackward = function()
  --   if not require("noice.lsp").scroll(-4) then
  --     return "<C-b>"
  --   end
  -- end,
}

M.dependencies = {
  ---@note if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  "MunifTanjim/nui.nvim",
  ---@optional:
  -- nvim-notify is only needed, if you want to use the notification view.
  -- If not available, we use 'mini' as the fallback
  "rcarriga/nvim-notify",
}

M.opts = {
  presets = {
    long_message_to_split = false,
    ---@desc position the cmdline and popupmenu together
    command_palette = true,
    bottom_search = false,
    lsp_doc_border = true,
  },
  health = {
    checker = true,
  },
  smart_move = {
    ---@desc noice tries to move out of the way of existing floating windows.
    enabled = false,
    ---@desc add any filetypes here, that shouldn't trigger smart move.
    excluded_filetypes = {
      "cmp_menu",
      "cmp_docs",
      "notify",
    },
  },
  views = {
    split = {
      ---@desc enter window on triggered
      enter = true,
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      opts = { skip = true },
      filter = {
        event = "msg_show",
        find = "written",
      },
    },
    ---@desc always route any messages with more than 20 lines to the split view
    {
      view = "split",
      filter = {
        event = "msg_show",
        min_height = 20,
      },
    },
  },
}

if Env.theme.colorscheme == "catppuccin" then
  ---@desc override default cmdline popup view
  M.opts.views.cmdline_popup = {
    border = {
      style = "round",
      padding = { 1, 2 },
    },
    win_options = {
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },
  }
end

M.repo = {
  "folke/noice.nvim",
  dependencies = M.dependencies,
  event = "VeryLazy",
  opts = M.opts,
  keys = {
    {
      "<S-Enter>",
      M.api.redirect_cmd,
      desc = "Redirect Cmdline",
      mode = "c",
    },
    {
      "<Leader>snl",
      M.api.noice_last_message,
      desc = "Noice Last Message",
    },
    {
      "<Leader>snh",
      M.api.noice_history,
      desc = "Noice History",
    },
    {
      "<Leader>sna",
      M.api.noice_all,
      desc = "Noice All",
    },
  },
}

return M
