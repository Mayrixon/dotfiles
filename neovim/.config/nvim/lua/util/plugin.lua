local Plugin = require("lazy.core.plugin")

---@class util.plugin
local M = {}

M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

---@type table<string, string>
M.deprecated_extras = {
  ["plugins.extras.formatting.conform"] = "`conform.nvim` is now the default **MyVim** formatter.",
  ["plugins.extras.linting.nvim-lint"] = "`nvim-lint` is now the default **MyVim** linter.",
  ["plugins.extras.ui.dashboard"] = "`dashboard.nvim` is now the default **MyVim** starter.",
  ["plugins.extras.coding.native_snippets"] = "Native snippets are now the default for **Neovim >= 0.10**",
  ["plugins.extras.editor.trouble-v3"] = "Trouble v3 has been merged in main",
}

M.deprecated_modules = {
  ["null-ls"] = "lsp.none-ls",
  ["nvim-navic.lib"] = "editor.navic",
  ["nvim-navic"] = "editor.navic",
}

---@type table<string, string>
M.renames = {
  ["windwp/nvim-spectre"] = "nvim-pack/nvim-spectre",
  ["jose-elias-alvarez/null-ls.nvim"] = "nvimtools/none-ls.nvim",
  ["null-ls.nvim"] = "none-ls.nvim",
  ["romgrk/nvim-treesitter-context"] = "nvim-treesitter/nvim-treesitter-context",
  ["glepnir/dashboard-nvim"] = "nvimdev/dashboard-nvim",
}

function M.setup()
  M.fix_imports()
  M.fix_renames()
  M.lazy_file()
end

function M.extra_idx(name)
  local Config = require("lazy.core.config")
  for i, extra in ipairs(Config.spec.modules) do
    if extra == "plugins.extras." .. name then
      return i
    end
  end
end

function M.lazy_file()
  -- This autocmd will only trigger when a file was loaded from the cmdline.
  -- It will render the file as quickly as possible.
  vim.api.nvim_create_autocmd("BufReadPost", {
    once = true,
    callback = function(event)
      -- Skip if we already entered vim
      if vim.v.vim_did_enter == 1 then
        return
      end

      -- Try to guess the filetype (may change later on during Neovim startup)
      local ft = vim.filetype.match({ buf = event.buf })
      if ft then
        -- Add treesitter highlights and fallback to syntax
        local lang = vim.treesitter.language.get_lang(ft)
        if not (lang and pcall(vim.treesitter.start, event.buf, lang)) then
          vim.bo[event.buf].syntax = ft
        end

        -- Trigger early redraw
        vim.cmd([[redraw]])
      end
    end,
  })

  -- Add support for the LazyFile event
  local Event = require("lazy.core.handler.event")

  Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
  Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

function M.fix_imports()
  Plugin.Spec.import = MyVim.inject.args(Plugin.Spec.import, function(_, spec)
    local dep = M.deprecated_extras[spec and spec.import]
    if dep then
      dep = dep .. "\n" .. "Please remove the extra from `lazyvim.json` to hide this warning."
      MyVim.warn(dep, { title = "MyVim", once = true, stacktrace = true, stacklevel = 6 })
      return false
    end
  end)
end

function M.fix_renames()
  Plugin.Spec.add = MyVim.inject.args(Plugin.Spec.add, function(self, plugin)
    if type(plugin) == "table" then
      if M.renames[plugin[1]] then
        MyVim.warn(
          ("Plugin `%s` was renamed to `%s`.\nPlease update your config for `%s`"):format(
            plugin[1],
            M.renames[plugin[1]],
            self.importing or "MyVim"
          ),
          { title = "MyVim" }
        )
        plugin[1] = M.renames[plugin[1]]
      end
    end
  end)
end

return M
