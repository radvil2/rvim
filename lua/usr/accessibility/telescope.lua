--- @desc fuzzy finder
local M = {}
local util = require("utils")

M.keys = {
  {
    "<Leader>/f",
    util.telescope("files"),
    desc = "Find Files (root dir)",
  },
  {
    "<Leader>/w",
    util.telescope("live_grep"),
    desc = "Find in Files (Grep)",
  },
  {
    "<Leader>/:",
    "<Cmd>Telescope command_history<Cr>",
    desc = "Command History",
  },
  {
    "<Leader>/b",
    "<Cmd>Telescope buffers<Cr>",
    desc = "Buffers",
  },
  {
    "<Leader>/o",
    "<Cmd>Telescope oldfiles<Cr>",
    desc = "Recent",
  },
  {
    "<Leader>/d",
    "<Cmd>Telescope diagnostics<Cr>",
    desc = "Diagnostics",
  },
  {
    "<Leader>/h",
    "<Cmd>Telescope help_tags<Cr>",
    desc = "Help Pages",
  },
  {
    "<Leader>/H",
    "<Cmd>Telescope highlights<Cr>",
    desc = "Search Highlight Groups",
  },
  {
    "<Leader>/k",
    "<Cmd>Telescope keymaps<Cr>",
    desc = "Key Maps",
  },
  {
    "<Leader>/M",
    "<Cmd>Telescope man_pages<Cr>",
    desc = "Man Pages",
  },
  {
    "<Leader>/c",
    util.telescope("colorscheme", { enable_preview = true }),
    desc = "Colorscheme with preview",
  },
  {
    "<Leader>/C",
    "<Cmd>Telescope commands<Cr>",
    desc = "Commands",
  },
  {
    "<Leader>/g",
    "<Cmd>Telescope git_commits<CR>",
    desc = "commits",
  },
  {
    "<Leader>/G",
    "<Cmd>Telescope git_status<CR>",
    desc = "status",
  },
  {
    "<Leader>/s",
    util.telescope("lsp_document_symbols", {
      symbols = {
        "Constructor",
        "Interface",
        "Property",
        "Function",
        "Method",
        "Module",
        "Struct",
        "Class",
        "Trait",
        "Field",
      },
    }),
    desc = "Goto Symbol",
  },
}

M.opts = function()
  local actions = require("telescope.actions")
  return {
    defaults = {
      prompt_prefix = " 🔭 ",
      selection_caret = " ",
      mappings = {
        ["i"] = {
          ["<A-Space>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
        },
        ["n"] = {
          ["q"] = actions.close,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.move_selection_next,
          ["sh"] = actions.select_horizontal,
          ["sv"] = actions.select_vertical,
        },
      },
    },
  }
end

M.repo = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = M.keys,
  opts = M.opts,
}

return M
