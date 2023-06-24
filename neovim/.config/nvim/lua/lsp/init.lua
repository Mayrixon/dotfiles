local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  print("Missing lspconfig.")
  return
end

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
  print("Missing cmp_nvim_lsp.")
  return
end

local preview_ok, preview = pcall(require, "goto-preview")
if preview_ok then
  preview.setup({ default_mappings = true, height = 20 })
else
  print("Missing goto-preview.")
end

local servers = require("lsp.servers")
local utils = require("lsp.utils")

local function get_general_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- for nvim-cmp
  capabilities = cmp_nvim_lsp.default_capabilities()

  return capabilities
end

local on_attach = function(client, bufnr)
  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok then
    navic.attach(client, bufnr)
  else
    print("Missing navic.")
  end

  local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
  if lsp_signature_ok then
    lsp_signature.on_attach({
      bind = true,
    }, bufnr)
  else
    print("Missing lsp_signature.")
  end

  local illuminate_ok, illuminate = pcall(require, "illuminate")
  if illuminate_ok then
    illuminate.on_attach(client)
  else
    print("Missing illuminate.")
  end

  utils.set_buffer_options(bufnr)

  utils.set_lsp_keymaps(client, bufnr)
end

-- Config diagnostic column signs.
local diagnostic_signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for name, sign in pairs(diagnostic_signs) do
  local sign_name = "DiagnosticSign" .. name
  vim.fn.sign_define(sign_name, { text = sign, texthl = sign_name, linehl = "", numhl = "" })
end

-- Config LSP servers.
local general_config = {
  capabilities = get_general_capabilities(),
  flags = { debounce_text_changes = 150 },
  on_attach = on_attach,
}

for server, config in pairs(servers.server_settings) do
  local server_config = vim.tbl_deep_extend("force", general_config, config)
  lspconfig[server].setup(server_config)

  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    print(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end

local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
if rust_tools_ok then
  rust_tools.setup({
    server = {
      on_attach = on_attach,
      capabilities = get_general_capabilities(),
    },
    tools = {
      hover_actions = {
        auto_focus = true,
      },
    },
  })
else
  print("Missing rust-tools.")
end
