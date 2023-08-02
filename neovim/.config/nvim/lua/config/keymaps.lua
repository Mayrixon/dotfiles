local Util = require("util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- -- Unmap <F1>
-- ["<F1>"] = "<ESC>",
-- TODO: config this command for variable OSs.
-- ['w!!'] = 'execute \'silent! write !sudo tee % >/dev/null\' <bar> edit!'

-- Move to window using the <Meta> hjkl keys
map("n", "<M-h>", "<C-W>h", { desc = "Go to left window", remap = true })
map("n", "<M-j>", "<C-W>j", { desc = "Go to lower window", remap = true })
map("n", "<M-k>", "<C-W>k", { desc = "Go to upper window", remap = true })
map("n", "<M-l>", "<C-W>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<M-Up>", "<Cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<M-Down>", "<Cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<M-Left>", "<Cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<M-Right>", "<Cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Add undo break-points
map("i", ",", ",<C-G>u")
map("i", ".", ".<C-G>u")
map("i", ";", ";<C-G>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Terminal mappings
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Enter Normal Mode" })
map("t", "<M-h>", "<Cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<M-j>", "<Cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<M-k>", "<Cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<M-l>", "<Cmd>wincmd l<CR>", { desc = "Go to right window" })

-- Fast copy/paste
map("n", "<Leader>P", '"+P', { desc = "Paste Before" })
map("n", "<Leader>Y", '"+Y', { desc = "Yank the Line" })
map("n", "<Leader>p", '"+p', { desc = "Paste After" })
map("v", "<Leader>p", '"+p', { desc = "Paste" })
map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank" })

-- Tabs
map("n", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader><Tab>c", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<Leader><Tab>f", "<Cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<Leader><Tab>l", "<Cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<Leader><Tab>n", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<Leader><Tab>p", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })

--keywordprg
map("n", "<Leader>K", "<Cmd>norm! K<CR>", { desc = "Keywordprg" })

-- Toggle options
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
map("n", "<Leader>Tc", function()
  Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })
map("n", "<Leader>Td", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<Leader>Tf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
if vim.lsp.inlay_hint then
  map("n", "<Leader>Th", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle Inlay Hints" })
end
map("n", "<Leader>Tl", function()
  Util.toggle_number()
end, { desc = "Toggle Line Numbers" })
map("n", "<Leader>Ts", function()
  Util.toggle("spell")
end, { desc = "Toggle Spelling" })
map("n", "<Leader>Tw", function()
  Util.toggle("wrap")
end, { desc = "Toggle Word Wrap" })

vim.cmd([[
  function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
      if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      endif
    endfor
  endfunction
]])
map("n", "<Leader>bc", "<Cmd>call DeleteHiddenBuffers()<CR>", { desc = "Clear all saved buffers" })

-- new file
map("n", "<Leader>fn", "<Cmd>enew<CR>", { desc = "New File" })

-- lazy
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Quit
map("n", "<Leader>qq", "<Cmd>qa<CR>", { desc = "Quit All" })

-- Utilities
-- Highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<Leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- Windows
map("n", "<Leader>-", "<Cmd>split<CR>", { desc = "Split window below", remap = true })
map("n", "<Leader>|", "<Cmd>vsplit<CR>", { desc = "Split window right", remap = true })
map("n", "<Leader>w=", "<C-W>=", { desc = "Equalise Height and Width", remap = true })
map("n", "<Leader>wc", "<Cmd>close<CR>", { desc = "Close window", remap = true })
map("n", "<Leader>ws", "<Cmd>split<CR>", { desc = "Split window below", remap = true })
map("n", "<Leader>wv", "<Cmd>vsplit<CR>", { desc = "Split window right", remap = true })
map("n", "<Leader>ww", "<C-W>p", { desc = "Other window", remap = true })

-- Diagnostic/Quickfix
map("n", "<Leader>xl", "<Cmd>lopen<CR>", { desc = "Location List" })
map("n", "<Leader>xq", "<Cmd>copen<CR>", { desc = "Quickfix List" })
