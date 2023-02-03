_G.Dump = function(...)
  print(vim.inspect(...))
end

_G.Api = vim.api

_G.CreateAutoCmd = Api.nvim_create_autocmd

_G.Log = function(msg, prefix)
  if not Env.devmode then
    return
  end
  prefix = prefix or "Log"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Type" }, { " ≫ " .. msg } }, true, {})
end

_G.Warn = function(msg, prefix)
  if not Env.devmode then
    return
  end
  prefix = prefix or "Warn"
  prefix = string.format("[%s]", prefix)
  vim.api.nvim_echo({ { prefix, "Label" }, { " ≫ " .. msg } }, true, {})
end

_G.IsEmpty = function(str)
  return str == nil or str == ""
end

_G.GetBufOpt = function(opt)
  local okay, buf_opt = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not okay then
    return nil
  else
    return buf_opt
  end
end

_G.IsFile = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

_G.IsDir = function(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

_G.Call = function(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  else
    return nil
  end
end

_G.Merge = function(tbl, partials)
  return vim.tbl_extend("force", tbl, partials or {})
end

_G.MergeIpairs = function(tbl1, tbl2)
  tbl1 = tbl1 or {}
  tbl2 = tbl2 or {}
  for _, value in ipairs(tbl2) do
    table.insert(tbl1, value)
  end
  return tbl1
end

_G.Map = function(mode, lhs, rhs, opts)
  opts = Merge({ silent = true, noremap = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

_G.MapBuf = function(bufnr, mode, lhs, rhs, opts)
  opts = Merge({ silent = true, noremap = true }, opts or {})
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

_G.IsBufferNotEmpty = function()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

_G.SetHl = function(hlGroup, options)
  vim.api.nvim_set_hl(0, hlGroup, options)
end

_G.IsGitWorkspace = function()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end

function _G.Import(path, filename)
  if filename or filename ~= nil then
    path = string.format(path .. ".%s", filename)
  end
  return require(path)
end
