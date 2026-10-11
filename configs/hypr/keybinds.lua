---------------------
---- KEYBINDINGS ----
---------------------
local M = {}

M.map_keybinds = function(apps)
	local screenshot = "noctalia msg screenshot-"
	hl.bind("Print", hl.dsp.exec_cmd(screenshot .. "region"))
	hl.bind("SUPER + Print", hl.dsp.exec_cmd(screenshot .. "fullscreen"))

	-- App launches
	hl.bind("ALT + F", hl.dsp.exec_cmd(apps.browser))
	hl.bind("ALT + S", hl.dsp.exec_cmd(apps.music))
	hl.bind("ALT + C", hl.dsp.exec_cmd(apps.terminal .. " -T \"hypr_py_child\" python"))

	-- Core window controls
	hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("noctalia msg session lock"))
	hl.bind("SUPER + Return", hl.dsp.exec_cmd(apps.terminal))
	hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
	hl.bind("SUPER + SHIFT + R", hl.dsp.exit())
	hl.bind("SUPER + E", hl.dsp.exec_cmd(apps.fileManager))
	hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
	hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen())
	hl.bind("SUPER + D", hl.dsp.exec_cmd(apps.menu))
	hl.bind("SUPER + B", hl.dsp.exec_cmd("pkill noctalia; noctalia -d"))
	hl.bind("SUPER + C", hl.dsp.window.center())
	hl.bind("SUPER + P", hl.dsp.window.pin())

	-- Focus movement (HJKL)
	hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
	hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
	hl.bind("SUPER + K", hl.dsp.layout("cycleprev"))
	hl.bind("SUPER + J", hl.dsp.layout("cyclenext"))

	-- Layout controls
	hl.bind("SUPER + SHIFT + Return", hl.dsp.layout("swapwithmaster"))
	hl.bind("SUPER + CTRL + Return", hl.dsp.layout("focusmaster master"))

	-- Workspace switching
	hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

	for i = 1, 9 do
	    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
	    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
	end

	-- Special workspace (scratchpad)
	hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
	hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

	-- Mouse window move/resize
	hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

	-- Audio / brightness
	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up 5"), { locked = true, repeating = true })
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down 5"), { locked = true, repeating = true })
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true, repeating = true })
	hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true, repeating = true })
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("noctalia msg brightness-up"), { locked = true, repeating = true })
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true, repeating = true })

	-- Media keys
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
	hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
end

return M
