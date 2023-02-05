---@desc extensible neovim scrollbar
local M = {}

M.id = "petertriho/nvim-scrollbar"

M.config = function()
  local opts = {
    excluded_filetypes = {
      "TelescopePrompt",
      "notify",
      "prompt",
      "noice",
    },
  }

  if Env.theme.colorscheme == "tokyonight" then
    local colors = require("tokyonight.colors").setup()
    opts.handle = { color = colors.bg_highlight }
    opts.marks = {
      Search = { color = colors.orange },
      Error = { color = colors.error },
      Warn = { color = colors.warning },
      Info = { color = colors.info },
      Hint = { color = colors.hint },
      Misc = { color = colors.purple },
    }
  end

  require("scrollbar").setup(opts)
end

M.repo = {
  M.id,
  event = "BufReadPost",
  config = M.config,
}

return M
