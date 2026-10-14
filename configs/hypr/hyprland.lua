hl.monitor({
    output   = "",
    mode     = "1920x1080@144",
    position = "auto",
    scale    = "auto",
})

local apps = {
	terminal_deamon = "foot --server",
	terminal    = "footclient",
	fileManager = "dolphin",
	menu        = "noctalia msg panel-toggle launcher",
	browser     = "zen-browser",
	music       = "supersonic",
}

hl.on("hyprland.start", function () 
  hl.exec_cmd(apps.terminal_deamon)
  hl.exec_cmd("hyprctl setcursor \"Breeze_Light\" 24")
  hl.exec_cmd("noctalia -d")
end)


hl.env("XCURSOR_THEME", "Breeze_Light")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Breeze_Light")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("MOZ_ENABLE_WAYLAND", "1")


require("appearance")
require("keybinds").map_keybinds(apps)
require("devices")
require("rules")


-- For Noctalia Color templates
require("noctalia").apply_theme()
