-- Lspsaga
-- add your config value here
-- default value
-- use_saga_diagnostic_sign = true
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
-- code_action_prompt = {
--   enable = true,
--   sign = true,
--   sign_priority = 20,
--   virtual_text = true,
-- },
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
-- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
-- finder_action_keys = {
--   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
-- },
-- code_action_keys = {
--   quit = 'q',exec = '<CR>'
-- },
-- rename_action_keys = {
--   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
-- },
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}
local saga = require('lspsaga')
saga.init_lsp_saga()

-- From coc.nvim suggesting Nerd-Fonts icons
-- "keyword": "\uf1de",
-- "variable": "\ue79b",
-- "value": "\uf89f",
-- "operator": "\u03a8",
-- "constructor": "\uf0ad",
-- "function": "\u0192",
-- "reference": "\ufa46", 渚 -> \uf079
-- "constant": "\uf8fe",  -> \ue22c
-- "method": "\uf09a",
-- "struct": "\ufb44",
-- "class": "\uf0e8",
-- "interface": "\uf417",  -> \ue729
-- "text": "\ue612",
-- "enum": "\uf435",  -> \uf902 車 -> \uf0ca
-- "enumMember": "\uf02b",
-- "module": "\uf40d",  -> \uf1c9
-- "color": "\ue22b",
-- "property": "\ue624",
-- "field": "\uf9be", 料 -> \ue707
-- "unit": "\uf475",
-- "event": "\ufacd", 鬒 -> \uf017
-- "file": "\uf723",
-- "folder": "\uf114",
-- "snippet": "\ue60b",
-- "typeParameter": "\uf728",
-- "default": "\uf29c"
local kind_symbols = {
  Keyword = '',
  Variable = '',
  Value = '',
  Operator = 'Ψ',
  Constructor = '',
  Function = 'ƒ',
  Reference = '',
  Constant = '',
  Method = '',
  Struct = 'פּ',
  Class = '',
  Interface = '',
  Text = '',
  Enum = '',
  EnumMember = '',
  Module = '',
  Color = '',
  Property = '',
  Field = '',
  Unit = '',
  Event = '',
  File = '',
  Folder = '',
  Snippet = '',
  TypeParameter = '',
  Default = ''
  -- Snippet = '﬌',
  -- Folder = '',
  -- Module = '',
  -- EnumMember = '',
  -- File = '',
}

require('lspkind').init({symbol_map = kind_symbols})
