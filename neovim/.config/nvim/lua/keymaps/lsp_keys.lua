local M = {}

M.non_leader = {
  normal = {
    ["[d"] = "<Cmd>lua vim.diagnostic.goto_prev()<CR>",
    ["]d"] = "<Cmd>lua vim.diagnostic.goto_next()<CR>",
    ["gD"] = "<Cmd>lua vim.lsp.buf.declaration()<CR>",
    ["gd"] = "<Cmd>lua vim.lsp.buf.definition()<CR>",
    ["gi"] = "<Cmd>lua vim.lsp.buf.implementation()<CR>",
    ["gr"] = "<Cmd>lua vim.lsp.buf.references()<CR>",
    ["K"] = "<Cmd>lua vim.lsp.buf.hover()<CR>",
    ["<C-k>"] = "<Cmd>lua vim.lsp.buf.signature_help()<CR>",
  },
}

M.leader = {
  normal = {
    l = {
      name = "LSP",

      a = { "<Cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
      D = {
        "<Cmd>TroubleToggle workspace_diagnostics<CR>",
        "Workspace diagnostics",
      },
      d = {
        "<Cmd>TroubleToggle document_diagnostics<CR>",
        "Document diagnostics",
      },
      f = { "<Cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
      r = { "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      o = { "<Cmd>Telescope lsp_document_symbols<CR>", "Document symbols" },
      w = {
        name = "Workspace",
        a = {
          function()
            vim.lsp.buf.add_workspace_folder()
          end,
          "Add Workspace folder",
        },
        l = {
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          "List workspace folders",
        },
        r = {
          function()
            vim.lsp.buf.remove_workspace_folder()
          end,
          "Remove Workspace folder",
        },
      },
    },
  },

  visual = {
    l = {
      name = "LSP",
      a = {
        function()
          vim.lsp.buf.range_code_action()
        end,
        "Range action",
      },
    },
  },
}

M.capability_mappings = {
  {
    "document_range_formatting",
    { lF = { "<Cmd>lua vim.lsp.buf.range_formatting()", "Range format" } },
    "<leader>",
    "visual",
  },
  {
    "code_lens",
    {
      l = {
        l = {
          name = "Code lens",

          l = { "<Cmd>lua vim.lsp.codelens.refresh()<CR>", "Codelens refresh" },
          r = { "<Cmd>lua vim.lsp.codelens.run()<CR>", "Codelens run" },
        },
      },
    },
    "<leader>",
    "normal",
  },
}

M.hints = {
  gD = "Declaration",
  gd = "Definition",
  gi = "implementation",
  gr = "References",
}

return M
