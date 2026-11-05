-- Option (Alt) word movement, plus the word/line deletes from
-- hammerspoon/delete-words.lua.
--
-- Terminals get the key sent straight back (or the shell's equivalent), since
-- zsh already understands Alt+arrows, Alt+Backspace and Ctrl+U.

local k = require("hypr.keyboard.util")
local send, split = k.send, k.split

-- Option+←/→ moves by word, Option+Shift+←/→ selects by word,
-- Option+Backspace deletes the previous word.
o.bind("ALT + LEFT", "Previous word", split(send({ "CTRL", "Left" }), send({ "ALT", "Left" })))
o.bind("ALT + RIGHT", "Next word", split(send({ "CTRL", "Right" }), send({ "ALT", "Right" })))
o.bind("ALT + SHIFT + LEFT", "Select previous word", split(send({ "CTRL + SHIFT", "Left" })))
o.bind("ALT + SHIFT + RIGHT", "Select next word", split(send({ "CTRL + SHIFT", "Right" })))
o.bind("ALT + BACKSPACE", "Delete previous word", split(send({ "CTRL", "BackSpace" }), send({ "ALT", "BackSpace" })))

-- Option+H / Option+L delete the previous/next word.
o.bind("ALT + H", "Delete previous word", split(send({ "CTRL", "BackSpace" }), send({ "CTRL", "W" })))
o.bind("ALT + L", "Delete next word", split(send({ "CTRL", "Delete" }), send({ "ALT", "D" })))

-- Ctrl+U deletes to the start of the line, Ctrl+; to the end. In terminals,
-- Ctrl+U is already native and Ctrl+K is the shell's kill-line. (Inside tmux,
-- Ctrl+K is pane navigation, so Ctrl+; won't kill the line there.)
o.bind("CTRL + U", "Delete to line start", split(send({ "SHIFT", "Home" }, { "", "BackSpace" }), send({ "CTRL", "U" })))
o.bind("CTRL + semicolon", "Delete to line end", split(send({ "SHIFT", "End" }, { "", "Delete" }), send({ "CTRL", "K" })))
