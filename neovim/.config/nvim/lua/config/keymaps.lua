-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = MyVim.safe_keymap_set

-- -- Unmap <F1>
-- ["<F1>"] = "<ESC>",
-- TODO: config this command for variable OSs.
-- ['w!!'] = 'execute \'silent! write !sudo tee % >/dev/null\' <bar> edit!'

-- Move to window using the <Meta> hjkl keys
map("n", "<M-h>", "<C-W>h", { desc = "Go to Left Window", remap = true })
map("n", "<M-j>", "<C-W>j", { desc = "Go to Lower Window", remap = true })
map("n", "<M-k>", "<C-W>k", { desc = "Go to Upper Window", remap = true })
map("n", "<M-l>", "<C-W>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<M-Up>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<M-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<M-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("n", "<M-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })

-- buffers
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<Cmd>e #<CR>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<Cmd>e #<CR>", { desc = "Switch to Other Buffer" })

-- Add undo break-points
map("i", ",", ",<C-G>u")
map("i", ".", ".<C-G>u")
map("i", ";", ";<C-G>u")

--keywordprg
map("n", "<Leader>K", "<Cmd>norm! K<CR>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- new file
map("n", "<Leader>fn", "<Cmd>enew<CR>", { desc = "New File" })

-- Diagnostic/Quickfix
map("n", "<Leader>xl", "<Cmd>lopen<CR>", { desc = "Location List" })
map("n", "<Leader>xq", "<Cmd>copen<CR>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
map({ "n", "v" }, "<leader>cf", function()
  MyVim.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Fast copy/paste
map("n", "<Leader>P", '"+P', { desc = "Paste Before" })
map("n", "<Leader>Y", '"+Y', { desc = "Yank the Line" })
map("n", "<Leader>p", '"+p', { desc = "Paste After" })
map("v", "<Leader>p", '"+p', { desc = "Paste" })
map({ "n", "v" }, "<Leader>y", '"+y', { desc = "Yank" })

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

-- stylua: ignore start

-- toggle options
map("n", "<Leader>Tf", function() MyVim.format.toggle() end, { desc = "Toggle Auto Format (Global)" })
map("n", "<Leader>TF", function() MyVim.format.toggle(true) end, { desc = "Toggle Auto Format (Buffer)" })
map("n", "<Leader>Ts", function() MyVim.toggle.option("spell") end, { desc = "Toggle Spelling" })
map("n", "<Leader>Tw", function() MyVim.toggle.option("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<Leader>TL", function() MyVim.toggle.option("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<Leader>Tl", function() MyVim.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<Leader>Td", function()MyVim.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
map("n", "<Leader>Tc", function() MyVim.toggle.option("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<Leader>Th", function() MyVim.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<Leader>TT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })

-- lazygit
map("n", "<Leader>gg", function() MyVim.lazygit({ cwd = MyVim.root.git() }) end, { desc = "Lazygit (root dir)" })
map("n", "<Leader>gG", function() MyVim.lazygit() end, { desc = "Lazygit (cwd)" })

map("n", "<Leader>gf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  MyVim.lazygit({ args={ "-f", vim.trim(git_path) }})
end, { desc = "Lazygit Current File History" })

-- quit
map("n", "<Leader>qq", "<Cmd>qa<CR>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<Leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
local lazyterm = function() MyVim.terminal(nil, { cwd = MyVim.root() }) end
map("n", "<Leader>ft", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<Leader>fT", function() MyVim.terminal() end, { desc = "Terminal (cwd)" })
map("n", "<C-/>", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<C-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<Esc><Esc>", "<C-\\><C-N>", { desc = "Enter Normal Mode" })
map("t", "<M-h>", "<Cmd>wincmd h<CR>", { desc = "Go to Left Window" })
map("t", "<M-j>", "<Cmd>wincmd j<CR>", { desc = "Go to Lower Window" })
map("t", "<M-k>", "<Cmd>wincmd k<CR>", { desc = "Go to Upper Window" })
map("t", "<M-l>", "<Cmd>wincmd l<CR>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<Cmd>close<CR>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<Cmd>close<CR>", { desc = "which_key_ignore" })

-- windows
map("n", "<Leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<Leader>wc", "<Cmd>close<CR>", { desc = "Close Window", remap = true })
map("n", "<Leader>w=", "<C-W>=", { desc = "Equalise Height and Width", remap = true })
map("n", "<Leader>ws", "<Cmd>split<CR>", { desc = "Split Window Below", remap = true })
map("n", "<Leader>wv", "<Cmd>vsplit<CR>", { desc = "Split Window Right", remap = true })
map("n", "<Leader>-", "<Cmd>split<CR>", { desc = "Split Window Below", remap = true })
map("n", "<Leader>|", "<Cmd>vsplit<CR>", { desc = "Split Window Right", remap = true })

-- tabs
map("n", "<Leader><Tab>l", "<Cmd>tablast<CR>", { desc = "Last Tab" })
map("n", "<Leader><Tab>f", "<Cmd>tabfirst<CR>", { desc = "First Tab" })
map("n", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "<Leader><Tab>n", "<Cmd>tabnext<CR>", { desc = "Next Tab" })
map("n", "<Leader><Tab>c", "<Cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<Leader><Tab>p", "<Cmd>tabprevious<CR>", { desc = "Previous Tab" })
