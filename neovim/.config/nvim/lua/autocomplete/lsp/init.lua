local utils = require('utils')

-- Set short updatetime for a shorter LSP update frequency
utils.opt('o', 'updatetime', 500)

local saga = require('lspsaga')
saga.init_lsp_saga({code_action_keys = {quit = {'<ESC>', 'q'}}})

require('autocomplete.lsp.appearance')

local lsp_status = require('lsp-status')
-- completion_customize_lsp_label as used in completion-nvim
-- Optional: customize the kind labels used in identifying the current function.
-- g:completion_customize_lsp_label is a dict mapping from LSP symbol kind 
-- to the string you want to display as a label
-- lsp_status.config { kind_labels = vim.g.completion_customize_lsp_label }

-- Register the progress handler
lsp_status.register_progress()

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
  -- config.capabilities = capabilities;
  -- Set default client capabilities plus window/workDoneProgress
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {},
                                       lsp_status.capabilities)
  lspconfig[server].setup(config)
end
