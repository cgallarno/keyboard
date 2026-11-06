-- Markdown Mode: the Omarchy counterpart of hammerspoon/markdown.lua.
--
-- Press Ctrl+M, then:
--   b => wrap the selected text in double asterisks ("b" for "bold")
--   c => wrap the selected text in backticks ("c" for "code")
--   i => wrap the selected text in single asterisks ("i" for "italic")
--   s => wrap the selected text in double tildes ("s" for "strikethrough")
--   l => turn the selected text into an inline link, using the URL on the
--        clipboard ("l" for "link")

local k = require("hypr.keyboard.util")

local function wrap(style)
  return function()
    -- Ctrl+C would interrupt the process in a terminal, so use Omarchy's
    -- terminal clipboard keys there.
    local chords = k.is_terminal() and "CTRL Insert SHIFT Insert" or "CTRL C CTRL V"
    hl.exec_cmd("keyboard-markdown-wrap " .. style .. " " .. chords)
  end
end

local mappings = {
  { "b", "bold" },
  { "c", "code" },
  { "i", "italic" },
  { "s", "strike" },
  { "l", "link" },
}

hl.define_submap("markdown", "reset", function()
  for _, mapping in ipairs(mappings) do
    o.bind(mapping[1], "Markdown mode: " .. mapping[2], wrap(mapping[2]))
  end

  o.bind("ESCAPE", "Leave markdown mode", hl.dsp.submap("reset"))
  o.bind("CTRL + M", "Leave markdown mode", hl.dsp.submap("reset"))
  o.bind("catchall", nil, hl.dsp.submap("reset"))
end)

o.bind("CTRL + M", "Markdown mode", hl.dsp.submap("markdown"))
