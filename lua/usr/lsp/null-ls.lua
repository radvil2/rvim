---@desc: languages linter and formatter
local M = {}

M.id = "jose-elias-alvarez/null-ls.nvim"

M.dependencies = { "mason.nvim" }

M.repo = {
	M.id,
	event = "BufReadPre",
	dependencies = M.dependencies,
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				nls.builtins.formatting.prettierd,
				nls.builtins.formatting.stylua,
			},
		}
	end,
}

return M
