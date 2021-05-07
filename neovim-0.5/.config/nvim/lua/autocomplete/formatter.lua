require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
      -- prettier
      function()
        return {
          exe = 'prettier',
          args = {
            '--stdin-filepath', vim.api.nvim_buf_get_name(0), '--single-quote'
          },
          stdin = true
        }
      end
    },
    -- rust = {
    --   -- Rustfmt
    --   function()
    --     return {exe = 'rustfmt', args = {'--emit=stdout'}, stdin = true}
    --   end
    -- },
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
    }
  }
})
