-- Default keybindings for launching apps in Hyper Mode (Right Option + key).
-- Same idea as hammerspoon/hyper-apps-defaults.lua: Hyper+key focuses the app
-- if it's open and launches it otherwise.
--
-- Each entry is { key, window-class pattern, launch command }. The pattern is
-- matched against window class and title by omarchy-launch-or-focus.
return {
  { "a", "spotify",            "omarchy-launch-spotify" },  -- "A" for "Apple Music"
  { "b", "chromium",           "omarchy-launch-browser" },  -- "B" for "Browser"
  { "c", "Slack",              "omarchy-launch-webapp https://app.slack.com/client" }, -- "C" for "Chat"
  { "e", "nvim",               "omarchy-launch-editor" },   -- "E" for "Editor"
  { "f", "org.gnome.Nautilus", "omarchy-launch-nautilus" }, -- "F" for "Finder"
  { "o", "obsidian",           "uwsm-app -- obsidian" },    -- "O" for "Obsidian"
  { "s", "Slack",              "omarchy-launch-webapp https://app.slack.com/client" }, -- "S" for "Slack"
  { "t", "ghostty|Alacritty|kitty|foot", "omarchy-launch-terminal" }, -- "T" for "Terminal"
}
