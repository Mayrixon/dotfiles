-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font Mono",
	{ family = "LXGW WenKai Mono Screen", italic = false },
})
config.window_background_opacity = 0.8

config.enable_tab_bar = false

config.mouse_bindings = {
	-- Shift-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SHIFT",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
