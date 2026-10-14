function float_center_rule(name, match, workspace)
    hl.window_rule({
        name = name,
        match = match,
        float = true,
        center = true,
	workspace = workspace,
        size = "1440 850",
    })
end

float_center_rule("supersonic-rule", { class = "io.github.supersonic-app.supersonic" }, "9")
float_center_rule("python-float-center", { title = "hypr_py_child" })

local kicad_floting_windows = { ".*Footprint Chooser.*", ".*3D Viewer.*"}
for i, value in ipairs(kicad_floting_windows) do
    float_center_rule("kicad-floating" .. i, { class = "kicad", title = value})
end

-----------------------------------
--- ====[Hyprland Defaults]==== ---
-----------------------------------
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})


-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- Screen share picker floating
hl.window_rule({
    name = "share-picker-float",
    match = { class = "hyprland-share-picker" },
    float = true,
})
