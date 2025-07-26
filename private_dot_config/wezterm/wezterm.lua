-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Font configuration
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })

-- Enable font fallback for better icon support
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold' }),
  },
  {
    intensity = 'Normal',
    italic = true,
    font = wezterm.font('JetBrainsMono Nerd Font', { style = 'Italic' }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold', style = 'Italic' }),
  },
}

-- Color scheme (optional - choose one you like)
config.color_scheme = 'Gruvbox Material (Gogh)'


-- Window configuration
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = '1.5cell',
  right = '1.5cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Performance
config.max_fps = 144
config.animation_fps = 60

-- Hyperlinks
local function is_shell(foreground_process_name)
  local shell_names = { 'bash', 'zsh', 'fish', 'sh', 'ksh', 'dash' }
  local process = string.match(foreground_process_name, '[^/\\]+$')
    or foreground_process_name
  for _, shell in ipairs(shell_names) do
    if process == shell then
      return true
    end
  end
  return false
end

wezterm.on('open-uri', function(window, pane, uri)
  local editor = 'nvim'

  if uri:find '^file:' == 1 and not pane:is_alt_screen_active() then
    -- We're processing an hyperlink and the uri format should be: file://[HOSTNAME]/PATH[#linenr]
    -- Also the pane is not in an alternate screen (an editor, less, etc)
    local url = wezterm.url.parse(uri)
    if is_shell(pane:get_foreground_process_name()) then
      -- A shell has been detected. Wezterm can check the file type directly
      -- figure out what kind of file we're dealing with
      local success, stdout, _ = wezterm.run_child_process {
        'file',
        '--brief',
        '--mime-type',
        url.file_path,
      }
      if success then
        if stdout:find 'directory' then
          pane:send_text(
            wezterm.shell_join_args { 'cd', url.file_path } .. '\r'
          )
          pane:send_text(wezterm.shell_join_args {
            'ls',
            '-a',
            '-p',
            '--group-directories-first',
          } .. '\r')
          return false
        end

        if stdout:find 'text' then
          if url.fragment then
            pane:send_text(wezterm.shell_join_args {
              editor,
              '+' .. url.fragment,
              url.file_path,
            } .. '\r')
          else
            pane:send_text(
              wezterm.shell_join_args { editor, url.file_path } .. '\r'
            )
          end
          return false
        end
      end
    else
      -- No shell detected, we're probably connected with SSH, use fallback command
      local edit_cmd = url.fragment
          and editor .. ' +' .. url.fragment .. ' "$_f"'
        or editor .. ' "$_f"'
      local cmd = '_f="'
        .. url.file_path
        .. '"; { test -d "$_f" && { cd "$_f" ; ls -a -p --hyperlink --group-directories-first; }; } '
        .. '|| { test "$(file --brief --mime-type "$_f" | cut -d/ -f1 || true)" = "text" && '
        .. edit_cmd
        .. '; }; echo'
      pane:send_text(cmd .. '\r')
      return false
    end
  end

  -- without a return value, we allow default actions
end)


config.mouse_bindings = {
	-- Copy and past using mouse
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action_callback(function(window, pane)
			local has_selection = window:get_selection_text_for_pane(pane) ~= ""
			if has_selection then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
				window:perform_action(act.ClearSelection, pane)
			else
				window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
			end
		end),
	},
  -- Change the default click behavior so that it only selects
  -- text and doesn't open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection 'ClipboardAndPrimarySelection',
  },

  -- and make CTRL-Click open hyperlinks
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },

}

return config
