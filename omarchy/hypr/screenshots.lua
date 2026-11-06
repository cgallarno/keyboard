-- macOS screenshot keys. Add Ctrl to copy to the clipboard instead of saving.
--
-- "smart" is a freeform drag, and a plain click snaps to the window under the
-- cursor, which covers both Cmd+Shift+4 and Cmd+Shift+4-then-Space.
-- Saving also copies to the clipboard and shows a preview notification that
-- opens the editor when clicked (closest thing to the Mac thumbnail).

o.bind("SUPER + SHIFT + code:12", "Screenshot screen", "omarchy-capture-screenshot fullscreen")
o.bind("SUPER + CTRL + SHIFT + code:12", "Screenshot screen to clipboard", "omarchy-capture-screenshot fullscreen copy")
o.bind("SUPER + SHIFT + code:13", "Screenshot area or window", "omarchy-capture-screenshot smart")
o.bind("SUPER + CTRL + SHIFT + code:13", "Screenshot area or window to clipboard", "omarchy-capture-screenshot smart copy")
o.bind("SUPER + SHIFT + code:14", "Capture menu", "omarchy-menu toggle capture")
