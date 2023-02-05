local M = {}

M.sidebars = {
  "dbui",
  "DiffViewFiles",
  "Mundo",
  "MundoDiff",
  "NvimTree",
  "NeoTree",
  "Outline",
}

M.treesitter = {
  "bash",
  "help",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

M.linters = {
  "prettierd",
  "shellcheck",
  "stylua",
  "flake8",
  "shfmt",
}

M.excludes = {
  "dirbuf",
  "fugitive",
  "fugitiveblame",
  "gitcommit",
  "help",
  "lspinfo",
  "NeogitStatus",
  "notify",
  "packer",
  "prompt",
  "qf",
  "TelescopePrompt",
  "TelescopeResults",
  unpack(M.sidebars),
}

return M
