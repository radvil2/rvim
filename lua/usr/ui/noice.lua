-- @desc: noicer UI
local M = {}

M.opts = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		long_message_to_split = true,
		command_palette = true,
		bottom_search = true,
	},
}

M.api = {
	redirect_cmd = function()
		require("noice").redirect(vim.fn.getcmdline())
	end,

	noice_last_message = function()
		require("noice").cmd("last")
	end,

	noice_history = function()
		require("noice").cmd("history")
	end,

	noice_all = function()
		require("noice").cmd("all")
	end,

	noice_lsp_scrollforward = function()
		if not require("noice.lsp").scroll(4) then
			return "<C-f>"
		end
	end,

	noice_lsp_scrollbackward = function()
		if not require("noice.lsp").scroll(-4) then
			return "<C-b>"
		end
	end,
}

M.repo = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = M.opts,
	-- TODO: for later ref
	-- keys = {
	-- 	{
	-- 		"<S-Enter>",
	-- 		M.api.redirect_cmd,
	-- 		desc = "Redirect Cmdline",
	-- 		mode = "c",
	-- 	},
	-- 	{
	-- 		"<Leader>snl",
	-- 		M.api.noice_last_message,
	-- 		desc = "Noice Last Message",
	-- 	},
	-- 	{
	-- 		"<Leader>snh",
	-- 		M.api.noice_history,
	-- 		desc = "Noice History",
	-- 	},
	-- 	{
	-- 		"<Leader>sna",
	-- 		M.api.noice_all,
	-- 		desc = "Noice All",
	-- 	},
	-- 	{
	-- 		"<C-f>",
	-- 		M.api.noice_lsp_scrollforward,
	-- 		desc = "Scroll forward",
	-- 		silent = true,
	-- 		expr = true,
	-- 	},
	-- 	{
	-- 		"<C-b>",
	-- 		M.api.noice_lsp_scrollbackward,
	-- 		desc = "Scroll backward",
	-- 		silent = true,
	-- 		expr = true,
	-- 	},
	-- },
}

return M
