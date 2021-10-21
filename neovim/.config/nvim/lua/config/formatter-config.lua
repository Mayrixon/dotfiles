local M = {}

local function clangformat()
  return {
    exe = 'clang-format',
    args = {
      '--assume-filename', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
    },
    stdin = true,
    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
  }
end

local function prettier()
  return {
    exe = 'prettier',
    args = {
      '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
      '--single-quote'
    },
    stdin = true
  }
end

function M.setup()
  require('formatter').setup({
    logging = false,
    filetype = {
      c = {clangformat},
      cmake = {
        function()
          return {
            exe = 'cmake-format',
            args = {vim.fn.expand('%:t')},
            stdin = false
          }
        end
      },
      cpp = {clangformat},
      html = {prettier},
      javascript = {prettier},
      json = {prettier},
      markdown = {prettier},
      lua = {
        -- lua-format
        function()
          return {
            exe = 'lua-format',
            args = {
              '--indent-width', vim.bo.shiftwidth,
              '--double-quote-to-single-quote'
            },
            stdin = true
          }
        end
      },
      python = {
        -- isort
        function()
          return {exe = 'isort', args = {'-', '--quiet'}, stdin = true}
        end, -- yapf
        function() return {exe = 'yapf', stdin = true} end
      },
      rust = {
        -- Rustfmt
        function()
          return {exe = 'rustfmt', args = {'--emit=stdout'}, stdin = true}
        end
      },
      tex = {
        -- latexindent
        function()
          return {
            exe = 'latexindent',
            args = {'-sl', '-g /dev/stderr', '2>/dev/null'},
            stdin = true
          }
        end
      },
      typescript = {prettier}
    }
  })
end

return M
-- TODO: refac export
