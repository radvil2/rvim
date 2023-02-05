local M = {}

M.id = "nvim-neo-tree/neo-tree.nvim"

M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
}

M.keys = {
  {
    "<Leader>e",
    "<Cmd>Neotree left<Cr>",
    desc = "Open left side tree",
  },
  {
    "<Leader><Space>",
    "<CMD>Neotree float<CR>",
    desc = "Open floating tree",
  },
}

M.opts = {
  enable_git_status = true,
  enable_diagnostics = true,
  close_if_last_window = true,
  popup_border_style = "rounded",
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      padding = 1,
      indent_size = 3,
      indent_marker = "│",
      with_markers = true,
      with_expanders = true,
      expander_expanded = "",
      expander_collapsed = "",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      highlight = "NeoTreeFileIcon",
      folder_closed = "",
      folder_empty = "ﰊ",
      folder_open = "",
      default = "*",
    },
    modified = {
      highlight = "NeoTreeModified",
      symbol = "[+]",
    },
    name = {
      highlight = "NeoTreeFileName",
      use_git_status_colors = true,
      trailing_slash = false,
    },
    git_status = {
      symbols = {
        added = "",
        modified = "💋",
        deleted = "✖",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  window = {
    width = 40,
    position = "left",
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = true } },
      -- disable `nowait` if you have existing combos
      -- starting with this char that you want to use
      ["<Space>"] = { "toggle_node", nowait = true },
      -- ["w"] = "open_with_window_picker",
      ["<Esc>"] = "revert_preview",
      ["<2-LeftMouse>"] = "open",
      ["z"] = "close_all_nodes",
      ["l"] = "focus_preview",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["C"] = "close_node",
      ["S"] = "open_split",
      ["<Cr>"] = "open",
      ["w"] = "open",
      -- ["Z"] = "expand_all_nodes",
      ["a"] = {
        "add",
        config = {
          show_path = "none",
        },
      },
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_hidden = true,
      hide_by_name = {
        --"node_modules"
      },
      hide_by_pattern = {
        "*.angular",
      },
      always_show = {
        ".gitignored",
      },
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
    group_empty_dirs = false,
    follow_current_file = false,
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["."] = "set_root",
        ["<bs>"] = "navigate_up",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["f"] = "filter_on_submit",
        ["<c-x>"] = "clear_filter",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
      },
    },
  },
  buffers = {
    follow_current_file = true,
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      -- mappings = {
      --   ["bd"] = "buffer_delete",
      --   ["<bs>"] = "navigate_up",
      --   ["."] = "set_root",
      -- },
    },
  },
  git_status = {
    window = {
      position = "float",
      -- mappings = {
      --   ["A"] = "git_add_all",
      --   ["gu"] = "git_unstage_file",
      --   ["ga"] = "git_add_file",
      --   ["gr"] = "git_revert_file",
      --   ["gc"] = "git_commit",
      --   ["gp"] = "git_push",
      --   ["gg"] = "git_commit_and_push",
      -- },
    },
  },
}

M.init = function()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  vim.cmd([[nnoremap \ :Neotree reveal<cr>]])

  vim.fn.sign_define("DiagnosticSignError", {
    texthl = "DiagnosticSignError",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignWarn", {
    texthl = "DiagnosticSignWarn",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignInfo", {
    texthl = "DiagnosticSignInfo",
    text = " ",
  })

  vim.fn.sign_define("DiagnosticSignHint", {
    texthl = "DiagnosticSignHint",
    text = "",
  })
end

M.repo = {
  M.id,
  opts = M.opts,
  init = M.init,
  keys = M.keys,
  enabled = true,
  branch = "v2.x",
  dependencies = M.dependencies,
}

return M
