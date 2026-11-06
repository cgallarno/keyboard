-- Window Layout Mode: the Omarchy counterpart of hammerspoon/windows.lua.
--
-- Press Ctrl+S, then one key. The mode exits after any action, or on Escape or
-- Ctrl+S again. Hyprland tiles windows, so "send window left" swaps it with
-- the neighbour on the left instead of snapping it to the left half.

local function center_float()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.dispatch(hl.dsp.window.center())
end

local mappings = {
  { "h",           "Move window left",        hl.dsp.window.swap({ direction = "l" }) },
  { "j",           "Move window down",        hl.dsp.window.swap({ direction = "d" }) },
  { "k",           "Move window up",          hl.dsp.window.swap({ direction = "u" }) },
  { "l",           "Move window right",       hl.dsp.window.swap({ direction = "r" }) },
  { "SHIFT + h",   "Narrower window",         hl.dsp.window.resize({ x = -100, y = 0, relative = true }) },
  { "SHIFT + l",   "Wider window",            hl.dsp.window.resize({ x = 100, y = 0, relative = true }) },
  { "SHIFT + k",   "Shorter window",          hl.dsp.window.resize({ x = 0, y = -100, relative = true }) },
  { "SHIFT + j",   "Taller window",           hl.dsp.window.resize({ x = 0, y = 100, relative = true }) },
  { "RETURN",      "Maximize window",         hl.dsp.window.fullscreen({ mode = "maximized" }) },
  { "f",           "Tiled full screen",       "omarchy-hyprland-window-tiled-fullscreen-toggle" },
  { "SPACE",       "Float and center window", center_float },
  { "n",           "Window to next monitor",  hl.dsp.window.move({ monitor = "+1" }) },
  { "LEFT",        "Window to left monitor",  hl.dsp.window.move({ monitor = "l" }) },
  { "RIGHT",       "Window to right monitor", hl.dsp.window.move({ monitor = "r" }) },
  { "SLASH",       "Toggle window split",     hl.dsp.layout("togglesplit") },
  { "p",           "Pop window out",          "omarchy-hyprland-window-pop" },
  { "t",           "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle" },
  { "g",           "Toggle window grouping",  hl.dsp.group.toggle() },
  { "m",           "Show scratchpad",         hl.dsp.workspace.toggle_special("scratchpad") },
}

hl.define_submap("window", "reset", function()
  for _, mapping in ipairs(mappings) do
    o.bind(mapping[1], "Window mode: " .. mapping[2], mapping[3])
  end

  o.bind("ESCAPE", "Leave window mode", hl.dsp.submap("reset"))
  o.bind("CTRL + S", "Leave window mode", hl.dsp.submap("reset"))
  o.bind("catchall", nil, hl.dsp.submap("reset"))
end)

o.bind("CTRL + S", "Window layout mode", hl.dsp.submap("window"))
