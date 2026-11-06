-- Make Cmd (Super) do what Cmd does on a Mac.
--
-- In apps, Cmd+key sends Ctrl+key. Terminals only get the keys that mean
-- something there; everything else is a no-op so Cmd+Z can't suspend a process.
-- Omarchy window-manager bindings that collide move to Ctrl+S mode
-- (windows.lua) or Hyper (hyper.lua).

local k = require("hypr.keyboard.util")
local send, split = k.send, k.split

-- Omarchy defaults that collide with Mac Cmd shortcuts.
k.unbind(
  "SUPER + W", "SUPER + F", "SUPER + T", "SUPER + J", "SUPER + O", "SUPER + P",
  "SUPER + L", "SUPER + K", "SUPER + S", "SUPER + G", "SUPER + RETURN",
  "SUPER + LEFT", "SUPER + RIGHT", "SUPER + UP", "SUPER + DOWN",
  "SUPER + SHIFT + LEFT", "SUPER + SHIFT + RIGHT", "SUPER + SHIFT + UP", "SUPER + SHIFT + DOWN",
  "SUPER + TAB", "SUPER + SHIFT + TAB", "SUPER + CTRL + LEFT", "SUPER + CTRL + RIGHT",
  "SUPER + code:20", "SUPER + code:21", "SUPER + comma", "SUPER + BACKSPACE", "SUPER + SLASH",
  "SUPER + CTRL + F",
  "SUPER + SHIFT + C", "SUPER + SHIFT + F", "SUPER + SHIFT + N", "SUPER + SHIFT + P",
  "SUPER + SHIFT + S", "SUPER + SHIFT + SLASH"
)
for digit = 0, 9 do
  k.unbind("SUPER + code:" .. tostring(digit + 10), "SUPER + SHIFT + code:" .. tostring(digit + 10))
end

-- Plain Cmd+letter → Ctrl+letter in apps, nothing in terminals.
-- (C, V, X stay on Omarchy's own universal clipboard bindings.)
for _, letter in ipairs({ "A", "B", "D", "E", "G", "I", "J", "L", "N", "O", "P", "R", "S", "U", "Y", "Z" }) do
  o.bind("SUPER + " .. letter, "Cmd+" .. letter, split(send({ "CTRL", letter })))
end

-- Cmd+Shift+letter → Ctrl+Shift+letter (redo, reopen tab, find in files,
-- command palette, save as, devtools, private window).
for _, letter in ipairs({ "C", "F", "N", "P", "S", "T", "Z" }) do
  o.bind("SUPER + SHIFT + " .. letter, "Cmd+Shift+" .. letter, split(send({ "CTRL + SHIFT", letter })))
end

o.bind("SUPER + F", "Find", split(send({ "CTRL", "F" }), send({ "CTRL + SHIFT", "F" })))
-- Terminal tabs use Ghostty's (and kitty's) Ctrl+Shift+T / Ctrl+Shift+W.
o.bind("SUPER + T", "New tab", split(send({ "CTRL", "T" }), send({ "CTRL + SHIFT", "T" })))
o.bind("SUPER + W", "Close tab", split(send({ "CTRL", "W" }), send({ "CTRL + SHIFT", "W" })))
o.bind("SUPER + Q", "Quit (close window)", hl.dsp.window.close())
o.bind("SUPER + K", "Cmd+K", split(send({ "CTRL", "K" }), send({ "CTRL", "L" })))
o.bind("SUPER + M", "Minimize (to scratchpad)", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
o.bind("SUPER + RETURN", "Cmd+Return", split(send({ "CTRL", "Return" })))
o.bind("SUPER + comma", "Preferences", split(send({ "CTRL", "comma" })))
o.bind("SUPER + SLASH", "Toggle comment", split(send({ "CTRL", "slash" })))
o.bind("SUPER + SHIFT + SLASH", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + backslash", "Passwords", { omarchy = "1password" })

-- Tabs: Cmd+1–9 pick a tab, Cmd+Shift+[ / ] previous/next tab, Cmd+[ / ] back/forward.
for digit = 1, 9 do
  o.bind("SUPER + code:" .. tostring(digit + 9), "Tab " .. digit, split(send({ "CTRL", tostring(digit) })))
end
o.bind("SUPER + SHIFT + bracketleft", "Previous tab", split(send({ "CTRL + SHIFT", "Tab" })))
o.bind("SUPER + SHIFT + bracketright", "Next tab", split(send({ "CTRL", "Tab" })))
o.bind("SUPER + bracketleft", "Back", split(send({ "ALT", "Left" })))
o.bind("SUPER + bracketright", "Forward", split(send({ "ALT", "Right" })))

-- Zoom (terminals use the same keys).
o.bind("SUPER + code:21", "Zoom in", send({ "CTRL", "equal" }))
o.bind("SUPER + code:20", "Zoom out", send({ "CTRL", "minus" }))
o.bind("SUPER + code:19", "Actual size", send({ "CTRL", "0" }))

-- Line and document navigation, plus Shift to select.
o.bind("SUPER + LEFT", "Line start", send({ "", "Home" }))
o.bind("SUPER + RIGHT", "Line end", send({ "", "End" }))
o.bind("SUPER + UP", "Document start", split(send({ "CTRL", "Home" })))
o.bind("SUPER + DOWN", "Document end", split(send({ "CTRL", "End" })))
o.bind("SUPER + SHIFT + LEFT", "Select to line start", split(send({ "SHIFT", "Home" })))
o.bind("SUPER + SHIFT + RIGHT", "Select to line end", split(send({ "SHIFT", "End" })))
o.bind("SUPER + SHIFT + UP", "Select to document start", split(send({ "CTRL + SHIFT", "Home" })))
o.bind("SUPER + SHIFT + DOWN", "Select to document end", split(send({ "CTRL + SHIFT", "End" })))
o.bind("SUPER + BACKSPACE", "Delete to line start",
  split(send({ "SHIFT", "Home" }, { "", "BackSpace" }), send({ "CTRL", "U" })))

-- Cmd+Tab switches windows. Spaces-style workspace switching moves to Cmd+Ctrl+arrows.
o.bind("SUPER + TAB", "Next window", hl.dsp.window.cycle_next())
o.bind("SUPER + SHIFT + TAB", "Previous window", hl.dsp.window.cycle_next({ next = false }))
o.bind("SUPER + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())
o.bind("SUPER + SHIFT + TAB", "Reveal active window on top", hl.dsp.window.bring_to_top())
o.bind("SUPER + CTRL + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + CTRL + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))

-- Mac's Ctrl+Cmd+F full screen.
o.bind("SUPER + CTRL + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
