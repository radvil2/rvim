local M = {}
local env = Env.theme

M.id = "EdenEast/nightfox.nvim"

M.opts = function()
  return {
    options = {
      transparent = env.transparentbg and env.darkmode,
      compile_path = Env.path.cache .. "/nightfox",
      compile_file_suffix = "_compiled",
      terminal_colors = true,
      dim_inactive = false,
      inverse = {
        match_paren = false,
        visual = false,
        search = true,
      },
      styles = {
        comments = "italic",
      },
    },
  }
end

---@type LazySpec
M.repo = {
  M.id,
  opts = M.opts,
  event = "VeryLazy", --TODO: set condition only if selected
  init = function()
    if env.colorscheme == "nightfox" then
      vim.cmd("colorscheme " .. env.variant)
      -- SetHl("Search", { bg = "NONE" })
    end
  end,
}

return M
