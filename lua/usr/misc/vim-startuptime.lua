local M = {}

M.id = "dstein64/vim-startuptime"

M.repo = {
	M.id,
	cmd = "StartupTime",
	config = function()
		vim.g.startuptime_tries = 10
	end,
}

return M
