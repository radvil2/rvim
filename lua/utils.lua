local M = {}
local util = require("lazy.core.util")

---@param plugin string
function M.has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

-- FIXME: create a togglable terminal
-- Opens a floating terminal (interactive by default)
---@param cmd? string[]|string
---@param opts? LazyCmdOptions|{interactive?:boolean}
function M.float_term(cmd, opts)
  require("lazy.util").float_term(
    cmd,
    Merge(opts or {}, {
      size = {
        width = 0.9,
        height = 0.9,
      },
    })
  )
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    local opt = { title = "Option" }
    return util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), opt)
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()

  if not silent then
    local opt = { title = "Option" }
    if vim.opt_local[option]:get() then
      util.info("Enabled " .. option, opt)
    else
      util.warn("Disabled " .. option, opt)
    end
  end
end

function M.toggle_diagnostics()
  Env.diagnostic_enabled = not Env.diagnostic_enabled

  local opt = { title = "Diagnostics" }
  if Env.diagnostic_enabled then
    vim.diagnostic.enable()
    util.info("Enabled diagnostics", opt)
  else
    vim.diagnostic.disable()
    util.warn("Disabled diagnostics", opt)
  end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)

  path = path ~= "" and vim.loop.fs_realpath(path) or nil

  ---@type string[]
  local roots = {}

  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end

  table.sort(roots, function(a, b)
    return #a > #b
  end)

  ---@type string?

  local root = roots[1]

  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()

    ---@type string?
    root = vim.fs.find(M.root_patterns, {
      path = path,
      upward = true,
    })[1]

    ---@diagnostic disable-next-line: cast-local-type
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end

  ---@cast root string
  return root
end

function M.quit_editor()
  if GetBufOpt("modified") then
    local prompt = "🚩 You have unsaved changes. Fucking quit anyway? (y/n) "
    vim.ui.input({ prompt = prompt }, function(input)
      if input == "y" then
        vim.cmd("qa!")
      end
    end)
  else
    vim.cmd("qa!")
  end
end

return M
