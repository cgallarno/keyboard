-- Hyper Mode: the Omarchy counterpart of hammerspoon/hyper.lua.
--
-- keyd turns Right Cmd (or Right Option) into Hyper (Super+Ctrl+Alt+Shift), like Karabiner
-- does on the Mac. Hyper+letter launches or focuses an app. Window-manager
-- actions that Cmd took over live here too.
--
-- To use your own apps, copy hyper-apps-defaults.lua to hyper-apps.lua and edit it.

local k = require("hypr.keyboard.util")
local HYPER = k.HYPER

local ok, apps = pcall(require, "hypr.keyboard.hyper-apps")
if not ok then
  apps = require("hypr.keyboard.hyper-apps-defaults")
end

for _, app in ipairs(apps) do
  local key, pattern, command = app[1], app[2], app[3]
  o.bind(HYPER .. " + " .. key, "Open " .. pattern,
    "omarchy-launch-or-focus " .. o.shell_quote(pattern) .. " " .. o.shell_quote(command))
end

-- Focus between tiled windows (Cmd+arrows now move the text cursor).
o.bind(HYPER .. " + h", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind(HYPER .. " + j", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind(HYPER .. " + k", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind(HYPER .. " + l", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- Workspaces (Cmd+1–9 now pick browser tabs).
for workspace = 1, 10 do
  o.bind(HYPER .. " + code:" .. tostring(workspace + 9), "Switch to workspace " .. workspace,
    hl.dsp.focus({ workspace = tostring(workspace) }))
end

o.bind(HYPER .. " + m", "Show keymap", "keyboard-keymap")
o.bind(HYPER .. " + comma", "Dismiss last notification", "omarchy-shell notifications dismissOne")
o.bind(HYPER .. " + BACKSPACE", "Toggle window transparency", "omarchy-hyprland-window-transparency-toggle")
o.bind(HYPER .. " + SLASH", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")
