local spectre_ok, spectre = pcall(require, "spectre")
if not spectre_ok then
  print("Missing spectre.")
  return
end

vim.cmd([[
  function! Scratch()
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
  endfunction
]])

local M = {}

M.normal = {

  b = {
    name = "Buffer",
    A = { "<Cmd>%bd|e#<CR>", "Delete all buffers" },
    f = { "<Cmd>bd!<CR>", "Force delete current buffer" },
    e = { "<Cmd>%d<CR>", "Erase buffer" },
    m = {
      "<Cmd>call Scratch() | put = execute('messages')<CR>",
      "Open message buffer",
    },
    N = {
      name = "New empty buffer",
      h = { "<Cmd>aboveleft vsplit enew<CR>", "New empty buffer left" },
      j = { "<Cmd>belowright split enew<CR>", "New empty buffer below" },
      k = { "<Cmd>aboveleft split enew<CR>", "New empty buffer above" },
      l = { "<Cmd>belowright vsplit enew<CR>", "New empty buffer right" },
      n = { "<Cmd>enew<CR>", "New empty buffer" },
    },
    n = { "<Cmd>bn<CR>", "Next buffer" },
    P = { "<Cmd>%d | put+<CR>", "Paste clipboard to whole buffer" },
    p = { "<Cmd>bp<CR>", "Previous buffer" },
    s = { "<Cmd>call Scratch()<CR>", "Scratch buffer" },
    w = { "<Cmd>setlocal readonly!<CR>", "Toggle Read-only mode" },
    Y = { "<Cmd>%y+<CR>", "Yank whole buffer to clipboard" },
  },

  s = {
    name = "Search",
    ["/"] = { "<Cmd>Telescope search_history<CR>", "Search history" },
    c = { "<Cmd>Telescope command_history<CR>", "Command history" },
    f = {
      function()
        spectre.open_file_search()
      end,
      "Open file search",
    },
    v = {
      function()
        spectre.open_visual({ select_word = true })
      end,
      "Visual search",
    },
    z = { "<Plug>SearchNormal", "Browser search" },
  },

  T = {
    name = "Toggle",
    c = { "<Cmd>ColorizerToggle<CR>", "Colorizer" },
    p = { "<Cmd>set paste!<CR>", "Paste mode" },
  },

  t = {
    name = "Tabs",
    ["1"] = { "1gt", "Tab 1" },
    ["2"] = { "2gt", "Tab 2" },
    ["3"] = { "3gt", "Tab 3" },
    ["4"] = { "4gt", "Tab 4" },
    ["5"] = { "5gt", "Tab 5" },
    ["6"] = { "6gt", "Tab 6" },
    ["7"] = { "7gt", "Tab 7" },
    ["8"] = { "8gt", "Tab 8" },
    ["9"] = { "9gt", "Tab 9" },
    ["0"] = { "10gt", "Tab 10" },
  },

  z = {
    name = "System",
    h = { "<Cmd>15sp +term<CR>", "New horizontal terminal" },
    M = { "<Cmd>messages clear<CR>", "Clear messages" },
    m = { "<Cmd>messages<CR>", "Messages" },
    t = { "<Cmd>terminal<CR>", "New terminal" },
    U = { "<Cmd>PackerSync<CR>", "Sync plugins" },
    u = { "<Cmd>PackerUpdate<CR>", "Update plugins" },
  },
}

M.visual = {

  s = {
    name = "Search",
    v = {
      "<Esc>:lua require('spectre').open_visual()<CR>",
      "Visual search",
    },
    z = { "<Plug>SearchVisual", "Browser search" },
  },

  u = {
    name = "Utilities",
    s = { "<Cmd>StripWhitespace<CR>", "Remove trailing whitespace" },
  },
}

return M
