-- Shared helpers for the Omarchy side of the keyboard.
--
-- Hyprland keeps Super (the physical Cmd key in the Keychron's Mac mode) as its
-- own modifier, so "Cmd behaves like a Mac" is done by binding SUPER + key and
-- sending CTRL + key to the focused app. Omarchy already does this for
-- Super+C/V/X in default/hypr/bindings/clipboard.lua; these helpers generalize
-- that pattern.

local M = {}

-- Send a chord with explicit mods to the focused surface. A virtual keyboard
-- (wtype) won't do: the physically held SUPER would merge into the injected
-- chord. The down/up split works around send_shortcut sometimes leaving the
-- synthetic key stuck. Same approach as Omarchy's clipboard.lua.
local function press(mods, key)
  hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

  hl.timer(function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
  end, { timeout = 50, type = "oneshot" })
end

-- Send one or more chords in order, each after the previous one is released.
-- Each chord is { mods, key }; use "" for no modifiers.
function M.send(...)
  local chords = { ... }
  return function()
    press(chords[1][1], chords[1][2])
    for index = 2, #chords do
      local chord = chords[index]
      hl.timer(function()
        press(chord[1], chord[2])
      end, { timeout = (index - 1) * 80, type = "oneshot" })
    end
  end
end

-- Lean on Omarchy's "terminal" window tag (default/hypr/apps/terminals.lua) so
-- there's one definition of what counts as a terminal. Dynamic tags carry a
-- trailing "*".
function M.is_terminal()
  local window = hl.get_active_window()
  if not window then
    return false
  end

  for _, tag in ipairs(window.tags or {}) do
    if tag:gsub("%*$", "") == "terminal" then
      return true
    end
  end

  return false
end

local function run(action)
  if type(action) == "function" then
    action()
  elseif action ~= nil then
    hl.dispatch(action)
  end
end

-- Do one thing in normal apps and another in terminals. Each side is a function
-- (usually from M.send), a dispatcher, or nil for "do nothing". Doing nothing
-- in terminals is deliberate for keys like Cmd+Z: forwarding Ctrl+Z would
-- suspend the foreground process.
function M.split(app, terminal)
  return function()
    if M.is_terminal() then
      run(terminal)
    else
      run(app)
    end
  end
end

-- Remove an Omarchy default before rebinding the key. Unbinding a key that
-- isn't bound is harmless.
function M.unbind(...)
  for _, keys in ipairs({ ... }) do
    hl.unbind(keys)
  end
end

M.HYPER = "SUPER + CTRL + ALT + SHIFT"

return M
