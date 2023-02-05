---@desc: language service provider
local M = {}

M.id = "neovim/nvim-lspconfig"

M.dependencies = {
	"mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
		config = true,
	},
	{
		"folke/neodev.nvim",
		opts = {
			experimental = {
				pathStrict = true,
			},
		},
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		cond = function()
			return require("utils").has("nvim-cmp")
		end,
	},
}

---@class PluginLspOpts
M.opts = {
	-- Options for vim.diagnostic.config()
	diagnostics = {
		update_in_insert = false,
		severity_sort = true,
		underline = true,
		virtual_text = {
			spacing = 4,
			prefix = require("media.icons").Misc.Squirrel,
		},
	},

	-- Automatically format on save
	autoformat = true,

	-- Options for vim.lsp.buf.format
	-- `bufnr` and `filter` is handled by the Rvim formatter,
	-- but can be also overriden when specified
	format = {
		formatting_options = nil,
		timeout_ms = nil,
	},
	-- LSP Server Settings
	---@type lspconfig.options
	servers = {
		jsonls = {},
		sumneko_lua = {
			-- mason = false, -- set to false if you don't want this server to be installed with mason
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		},
	},
	-- You can do any additional lsp server setup here

	-- return true if you don't want this server to be setup with lspconfig
	---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
	setup = {
		-- Example to setup with typescript.nvim

		-- tsserver = function(_, opts)
		--   require("typescript").setup({ server = opts })
		--   return true
		-- end,
		-- Specify * to use this function as a fallback for any server
		-- ["*"] = function(server, opts) end,
	},
}

---@param opts PluginLspOpts
M.config = function(_, opts)
	-- Setup autoformat
	require("usr.lsp.common.formatter").autoformat = opts.autoformat

	-- Setup formatting and keymaps
	local lsp_attach_fn = function(client, buffer)
		require("usr.lsp.common.formatter").on_attach(client, buffer)
		require("usr.lsp.common.keymapper").on_attach(client, buffer)
	end

	require("usr.lsp.common.utils").on_attach(lsp_attach_fn)

	-- Diagnostics
	for name, icon in pairs(require("media.icons").Diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end

	vim.diagnostic.config(opts.diagnostics)

	local servers = opts.servers
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local okay, nvim_cmp = pcall(require, "cmp_nvim_lsp")
	if okay then
		capabilities = nvim_cmp.default_capabilities(capabilities)
	end

	local function setup(server)
		local server_opts = servers[server] or {}
		server_opts.capabilities = capabilities
		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	local mlsp = require("mason-lspconfig")
	local available = mlsp.get_available_servers()

	local ensure_installed = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false
			-- or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(available, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup_handlers({ setup })
end

M.repo = {
	M.id,
	dependencies = M.dependencies,
	event = "BufReadPre",
	config = M.config,
	opts = M.opts,
}

return M

