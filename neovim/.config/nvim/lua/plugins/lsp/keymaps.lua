local M = {}

---@type MyKeysLspSpec[]|nil
M._keys = nil

---@alias MyKeysLspSpec MyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias MyKeysLsp MyKeys|{has?:string|string[], cond?:fun():boolean}

---@return MyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
    -- stylua: ignore
    M._keys = {
      { "<Leader>cl", "<Cmd>LspInfo<CR>", desc = "Lsp Info" },
      { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition", has = "definition" },
      { "gr", "<Cmd>Telescope lsp_references<CR>", desc = "References", nowait = true },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
      { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<C-K>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "<Leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<Leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
      { "<Leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
      { "<Leader>cR", MyVim.lsp.rename_file, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
      { "<Leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
      {
        "<Leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      },
      { "]]", function() MyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight",
        desc = "Next Reference", cond = function() return MyVim.lsp.words.enabled end },
      { "[[", function() MyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight",
        desc = "Prev Reference", cond = function() return MyVim.lsp.words.enabled end },
      { "<M-n>", function() MyVim.lsp.words.jump(vim.v.count1, true) end, has = "documentHighlight",
        desc = "Next Reference", cond = function() return MyVim.lsp.words.enabled end },
      { "<M-p>", function() MyVim.lsp.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
        desc = "Prev Reference", cond = function() return MyVim.lsp.words.enabled end },
    }

  return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = MyVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return MyKeysLsp[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = MyVim.opts("nvim-lspconfig")
  local clients = MyVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
