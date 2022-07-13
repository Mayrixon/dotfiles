local packer = nil
local function init()
  if packer == nil then
    packer = require("packer")
    packer.init({ disable_commands = true })
  end

  local use = packer.use
  packer.reset()

  use("mhinz/vim-sayonara")

  -- Marks
  -- use { 'kshenoy/vim-signature', config = [[require('config.signature')]], disable = true }

  -- Movement
  use({ "chaoren/vim-wordmotion", "justinmk/vim-sneak" })

  -- Quickfix
  use({ "Olical/vim-enmasse", cmd = "EnMasse" })
  use("kevinhwang91/nvim-bqf")

  -- Wrapping/delimiters
  use({
    "machakann/vim-sandwich",
    { "andymass/vim-matchup", setup = [[require('config.matchup')]], event = "User ActuallyEditing" },
  })

  -- Search
  use("romainl/vim-cool")

  -- Text objects
  use("wellle/targets.vim")

  -- Project Management/Sessions
  use({
    "dhruvasagar/vim-prosession",
    after = "vim-obsession",
    requires = { { "tpope/vim-obsession", cmd = "Prosession" } },
    config = [[require('config.prosession')]],
  })

  -- REPLs
  use({
    "hkupty/iron.nvim",
    setup = [[vim.g.iron_map_defaults = 0]],
    config = [[require('config.iron')]],
    cmd = { "IronRepl", "IronSend", "IronReplHere" },
  })

  -- Completion and linting
  use({
    "neovim/nvim-lspconfig",
    "~/projects/personal/lsp-status.nvim",
    "folke/trouble.nvim",
    "ray-x/lsp_signature.nvim",
    "kosayoda/nvim-lightbulb",
  })

  -- C++
  use("p00f/clangd_extensions.nvim")

  -- Documentation
  use({
    "danymat/neogen",
    requires = "nvim-treesitter",
    config = [[require('config.neogen')]],
    keys = { "<localleader>d", "<localleader>df", "<localleader>dc" },
  })

  -- Lisps
  use("gpanders/nvim-parinfer")

  -- Endwise
  -- use 'tpope/vim-endwise'
  use("RRethy/nvim-treesitter-endwise")

  -- Debugger
  use({
    {
      "mfussenegger/nvim-dap",
      setup = [[require('config.dap_setup')]],
      config = [[require('config.dap')]],
      requires = "jbyuki/one-small-step-for-vimkind",
      wants = "one-small-step-for-vimkind",
      module = "dap",
    },
    {
      "rcarriga/nvim-dap-ui",
      requires = "nvim-dap",
      after = "nvim-dap",
      config = function()
        require("dapui").setup()
      end,
    },
  })

  use({
    "puremourning/vimspector",
    setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
    disable = true,
  })

  -- Path navigation
  use("justinmk/vim-dirvish")

  -- Meson
  use("igankevich/mesonic")

  -- PDDL
  use("PontusPersson/pddl.vim")

  -- Zig
  use("ziglang/zig.vim")

  -- Julia
  use({ "JuliaEditorSupport/julia-vim", setup = [[vim.g.latex_to_unicode_tab = 'off']], opt = true })

  -- Refactoring
  use("ThePrimeagen/refactoring.nvim")
  -- Plugin development
  use("folke/lua-dev.nvim")

  -- Notes
  use({
    "~/projects/personal/pdf-scribe.nvim",
    config = [[require('config.pdf_scribe')]],
    disable = true,
  })

  use({ { "nvim-orgmode/orgmode.nvim", config = [[require('config.orgmode')]] }, "akinsho/org-bullets.nvim" })

  -- Buffer management
  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[require('config.bufferline')]],
    event = "User ActuallyEditing",
  })

  use({
    "lukas-reineke/headlines.nvim",
    config = function()
      require("headlines").setup()
    end,
  })

  use("teal-language/vim-teal")
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
  -- use {
  --   'AckslD/nvim-neoclip.lua',
  --   event = 'TextYankPost',
  --   config = function()
  --     local count = 0
  --     _G.test_handler = function()
  --       count = count + 1
  --       print('called', count, 'times')
  --     end
  --     vim.cmd [[autocmd TextYankPost * lua _G.test_handler()]]
  --   end,
  -- }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
