-- Student desktop: only Canvas, Omawrite and Omacalc. Loaded from the student's
-- root-owned ~/.config/hypr/hyprland.lua.
--
-- Lua modules load only from Omarchy's install, never from the home folder, so a
-- student can't swap in their own code. Omarchy's bar, menu and terminal bindings
-- are left out on purpose.
package.path = "/usr/share/omarchy/?.lua"
package.cpath = ""

require("default.hypr.helpers")
require("default.hypr.envs")
require("default.hypr.looknfeel")
require("default.hypr.input")
require("default.hypr.windows")
require("default.hypr.bindings.media")

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
end)

-- Add Omadesmos (4) and Omaterminus (5) here once they ship.
local apps = {
  { key = "1", name = "Canvas", match = "OmaCanvas", command = "omacanvas" },
  { key = "2", name = "Omawrite", match = "omawrite", command = "omawrite" },
  { key = "3", name = "Omacalc", match = "omacalc", command = "omacalc" },
}
for _, app in ipairs(apps) do
  o.bind("SUPER + " .. app.key, app.name, { launch = app.command, focus = app.match })
end

o.bind("SUPER + W", "Close window", hl.dsp.window.close())
o.bind("SUPER + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("SUPER + LEFT", "Focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + RIGHT", "Focus right", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + UP", "Focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + DOWN", "Focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + ESCAPE", "Log out", "omarchy-system-logout")
