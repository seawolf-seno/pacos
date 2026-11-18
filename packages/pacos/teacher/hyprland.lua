-- Teacher desktop: classroom defaults on top of Omarchy's own. Loaded at the end
-- of each teacher's ~/.config/hypr/hyprland.lua (pacos-teacher-hyprland adds the
-- line), so it runs after Omarchy's default bindings and can change them.
-- The package owns this file: updates reach every teacher without touching
-- their home folder. A teacher who deletes that line gets plain Omarchy back.

-- Mirror the laptop to the projector with a shortcut that has no Alt in it
-- (M for mirror). Omarchy's Super + Ctrl + Alt + Delete still works.
o.bind("SUPER + CTRL + M", "Toggle laptop display mirroring", "omarchy-hyprland-monitor-internal-mirror toggle")

-- No hold-Right-Alt dictation. Pressing the mirror shortcut with the right Alt
-- key started recording the classroom, and the display switch could swallow
-- the key release, so it kept recording for up to a minute. Alt + Space still
-- starts and stops dictation on purpose.
hl.unbind("ALT + Alt_R")
