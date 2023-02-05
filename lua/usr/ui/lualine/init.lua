-- @desc: nice statusline
local M = {}
local env = Env.editor.statusline

M.id = "nvim-lualine/lualine.nvim"

M.dependencies = { "arkav/lualine-lsp-progress" }

M.opts = {}

if env.variant == "rainbow" then
	M.opts = require("usr.ui.lualine.rainbow")
else
	M.opts = require("usr.ui.lualine.default")
end

M.repo = {
	M.id,
	dependencies = M.dependencies,
	enabled = env.enable,
	opts = M.opts,
}

return M
