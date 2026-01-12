local wezterm                       = require 'wezterm'

local config                        = wezterm.config_builder()

-- Define nerv color scheme
config.color_schemes = {
    nerv = {
        background = '#0a1612',
        foreground = '#8fb3a5',
        ansi = {
            '#0a1612',  -- black
            '#c92a2a',  -- red
            '#4a8c5c',  -- green
            '#d4a017',  -- yellow
            '#3a7a8c',  -- blue
            '#8a5a8a',  -- magenta
            '#5a9a8c',  -- cyan
            '#8fb3a5',  -- white
        },
        brights = {
            '#4a6a5d',  -- bright black
            '#e85d04',  -- bright red
            '#5aac6c',  -- bright green
            '#e4b027',  -- bright yellow
            '#4a8a9c',  -- bright blue
            '#9a6a9a',  -- bright magenta
            '#6aaa9c',  -- bright cyan
            '#a8d3c5',  -- bright white
        },
    },
}

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity    = 1
config.macos_window_background_blur = 0
config.initial_cols                 = 150
config.initial_rows                 = 40

config.color_scheme                 = "nerv"
config.window_close_confirmation    = "NeverPrompt"

-- Use font_with_fallback for better compatibility
-- Try different font name variations: 'Berkeley Mono', 'BerkeleyMono Nerd Font'
-- Add Chinese fonts to support CJK characters
config.font                         = wezterm.font_with_fallback {
    { family = 'Berkeley Mono', weight = 'Light' },
    { family = 'BerkeleyMono Nerd Font', weight = 'Regular' },
    'JetBrains Mono',  -- fallback if Berkeley Mono not found
    'PingFang SC',     -- Chinese font for macOS (primary)
    'Hiragino Sans GB', -- Another Chinese font fallback
}
config.font_size                    = 13
config.freetype_load_target         = 'Light'
config.freetype_render_target       = 'HorizontalLcd'
config.enable_scroll_bar            = false
config.use_fancy_tab_bar            = false
config.tab_bar_at_bottom            = true
config.window_decorations           = 'RESIZE'
config.default_cursor_style         = 'BlinkingBlock'
local act                           = wezterm.action

local mod                           = {
    SUPER = "SUPER",
    SUPER_REV = 'SUPER|SHIFT',
    OPT = 'OPT',
}

config.leader                       = { key = 'b', mods = 'CTRL' }
config.mouse_bindings               = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = mod.SUPER,
        action = act.OpenLinkAtMouseCursor,
    },
}
config.key_tables                   = {
    resize_pane = {
        { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

config.keys                         = {
    -- panes: split panes
    {
        key = [[\]],
        mods = mod.SUPER,
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = [[\]],
        mods = mod.SUPER_REV,
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },


    -- panes: zoom+close pane
    { key = 'Enter', mods = mod.SUPER, action = act.TogglePaneZoomState },
    { key = 'w',     mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { key = 'k',     mods = 'LEADER',  action = act.ActivatePaneDirection('Up') },
    { key = 'j',     mods = 'LEADER',  action = act.ActivatePaneDirection('Down') },
    { key = 'h',     mods = 'LEADER',  action = act.ActivatePaneDirection('Left') },
    { key = 'l',     mods = 'LEADER',  action = act.ActivatePaneDirection('Right') },

    -- panes: resize_pane
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timeout_milliseconds = 1000,
        }),
    },

    {
        key = 'p',
        mods = mod.SUPER,
        action = act.ActivateCommandPalette
    },
    {
        key = 'u',
        mods = mod.SUPER,
        action = wezterm.action.QuickSelectArgs({
            label = 'open url',
            patterns = {
                '\\((https?://\\S+)\\)',
                '\\[(https?://\\S+)\\]',
                '\\{(https?://\\S+)\\}',
                '<(https?://\\S+)>',
                '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end),
        }),
    },

    -- tabs: navigation
    { key = '[', mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
    { key = ']', mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
    { key = '[', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
    { key = ']', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

    -- tabs: quick switch with number keys
    { key = '1', mods = mod.SUPER,     action = act.ActivateTab(0) },
    { key = '2', mods = mod.SUPER,     action = act.ActivateTab(1) },
    { key = '3', mods = mod.SUPER,     action = act.ActivateTab(2) },
    { key = '4', mods = mod.SUPER,     action = act.ActivateTab(3) },
    { key = '5', mods = mod.SUPER,     action = act.ActivateTab(4) },
    { key = '6', mods = mod.SUPER,     action = act.ActivateTab(5) },
    { key = '7', mods = mod.SUPER,     action = act.ActivateTab(6) },
    { key = '8', mods = mod.SUPER,     action = act.ActivateTab(7) },
    { key = '9', mods = mod.SUPER,     action = act.ActivateTab(-1) },  -- last tab

    {
        key = ',',
        mods = mod.OPT,
        action = wezterm.action_callback(function(window, pane)
            local wez_config_path = os.getenv('HOME') .. '/.config/wezterm/wezterm.lua'
            wezterm.log_info('wez config' .. wez_config_path)
            window:perform_action(
                wezterm.action.SpawnCommandInNewTab {
                    args = { 'nvim', wez_config_path },
                    set_environment_variables = {
                        PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
                    },
                },
                pane
            )
        end),
    },

    -- copy mode
    { key = 'Enter', mods = mod.SUPER_REV, action = 'ActivateCopyMode' },
}

return config
