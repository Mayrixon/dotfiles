local utils = require('utils')

-- Set short updatetime for a shorter LSP update frequency
utils.opt('o', 'updatetime', 500)

local saga = require('lspsaga')
saga.init_lsp_saga({code_action_keys = {quit = {'<ESC>', 'q'}}})

require('autocomplete.lsp.appearance')

local on_attach = require('autocomplete.lsp.on_attach')

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- LSPs
-- local servers = { "pyright", "rust_analyzer", "tsserver", "vimls"}
-- for _, lsp in ipairs(servers) do
--     nvim_lsp[lsp].setup {
--         capabilities = capabilities;
--         on_attach = on_attach;
--         -- init_options = {
--         --     onlyAnalyzeProjectsWithOpenFiles = true,
--         --     suggestFromUnimportedLibraries = false,
--         --     closingLabels = true,
--         -- };
--     }
-- end
local servers = require('autocomplete.lsp.servers')
for server, config in pairs(servers) do
  config.on_attach = on_attach;
  config.capabilities = capabilities;
  lspconfig[server].setup(config)
end
