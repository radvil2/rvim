---@desc: cmdline tools and lsp servers
local M = {}

M.id = "williamboman/mason.nvim"

M.keys = {
	{
		"<Leader>cm",
		"<Cmd>Mason<Cr>",
		desc = "Mason",
	},
}

M.opts = {
	ensure_installed = {
		"shellcheck",
		"stylua",
		"flake8",
		"shfmt",
	},
}

---@param opts MasonSettings | {ensure_installed: string[]}
M.config = function(_, opts)
	require("mason").setup(opts)
	local mr = require("mason-registry")
	for _, tool in ipairs(opts.ensure_installed) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end

M.repo = {
	M.id,
	cmd = "Mason",
	keys = M.keys,
	opts = M.opts,
	config = M.config,
}

return M
