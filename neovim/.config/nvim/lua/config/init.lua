require("config/options")
require("config/plugins")

-- Colorscheme
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")

require("config/autocmds")
require("config/keymaps")

local M = {}

M.icons = {
	misc = {
		dots = "󰇘",
	},
	dap = {
		Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = "",
		BreakpointCondition = "",
		BreakpointRejected = { "", "DiagnosticError" },
		LogPoint = ".>",
	},
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		deleted = " ",
		modified = " ",
		renamed = " ",
		unstaged = "󰄱 ",
		ignored = " ",
		staged = "󰱒 ",
		conflict = " ",
	},
	kinds = {
		Array = " ",
		Boolean = " ",
		Class = " ",
		Codeium = "󰘦 ",
		Color = " ",
		Constant = " ",
		Constructor = " ",
		Copilot = " ",
		Enum = " ",
		EnumMember = " ",
		Event = " ",
		Field = " ",
		File = " ",
		Folder = " ",
		Function = " ",
		Interface = " ",
		Key = " ",
		Keyword = " ",
		Method = " ",
		Module = " ",
		Namespace = " ",
		Null = " ",
		Number = " ",
		Object = " ",
		Operator = " ",
		Package = " ",
		Property = " ",
		Reference = " ",
		Snippet = " ",
		String = " ",
		Struct = " ",
		Text = " ",
		TypeParameter = " ",
		Unit = " ",
		Value = " ",
		Variable = " ",
	},
}

return M
