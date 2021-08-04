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
