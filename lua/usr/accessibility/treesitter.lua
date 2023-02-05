--- @desc: syntax tree hi, hirarchy, etc, etc, ...

local M = {}

M.id = "nvim-treesitter/nvim-treesitter"

M.dependencies = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "nvim-treesitter/nvim-treesitter-context",
  {
    "radvil2/nvim-treesitter-angular",
    branch = "jsx-parser-fix",
    ft = "typescript",
  },
}

M.keys = {
  {
    "<C-Space>",
    desc = "Increment selection",
  },
  {
    "<Bs>",
    desc = "Schrink selection",
    mode = "x",
  },
}

--- @type TSConfig
M.opts = {
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  indent = { enable = true },
  context_commentstring = {
    enable_autocmd = false,
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "<C-Space>",
      init_selection = "<C-Space>",
      scope_incremental = "<Nop>",
      node_decremental = "<Bs>",
    },
  },
}

--- @param opts TSConfig
M.config = function(_, opts)
  local has_plugin = require("utils").has
  opts.ensure_installed = require("opt.filetype").treesitter
  if has_plugin("ts-rainbow") then
    opts.rainbow = {
      extended_mode = true,
      max_file_lines = 1000,
      enable = true,
    }
  end
  require("nvim-treesitter.configs").setup(opts)
end

M.repo = {
  M.id,
  event = "BufReadPost",
  build = ":TSUpdate",
  config = M.config,
  opts = M.opts,
  keys = M.keys,
}

return M
