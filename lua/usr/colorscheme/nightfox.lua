local M = {}
local env = Env.theme
local variant = env.colorvariant or "nightfox"
local transbg = env.transparentbg
local darkmode = env.darkmode

M.opts = {
	options = {
		compile_path = Env.path.cache .. "/nightfox",
		compile_file_suffix = "_compiled",
		transparent = transbg,
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

if not darkmode then
	variant = "dayfox"
	transbg = false
end

M.repo = {
	"EdenEast/nightfox.nvim",
	lazy = env.colorscheme ~= "nightfox",
	config = function()
		local nightfox = Call("nightfox")
		if not nightfox then
			vim.notify("nightfox was not installed!", vim.log.levels.ERROR)
			return
		end
		nightfox.setup(M.opts)
		if env.colorscheme == "nightfox" then
			vim.cmd("colorscheme " .. variant)
			SetHl("Search", { bg = "NONE" })
		end
	end,
}

return M
