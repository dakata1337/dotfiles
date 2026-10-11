-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 15,
        border_size = 2,

        col = {
            active_border   = "rgba(c0c0c0ff)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "master",
    },

    decoration = {
        rounding       = 1,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = false,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.layer_rule({
    name = "wofi-no-animations",
    match = { namespace = "^wofi$" },
    no_anim = true,
})


-- Curves (keep your existing definitions)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy", {
    type = "spring",
    mass = 1,
    stiffness = 238.1191,
    dampening = 24.21279333,
})

-- Global
hl.animation({ leaf = "global",        enabled = true, speed = 7,    bezier = "default" })

-- Borders
hl.animation({ leaf = "border",        enabled = true, speed = 3,    bezier = "easeOutQuint" })

-- Windows
hl.animation({ leaf = "windows",       enabled = true, speed = 3.5,  spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3.2,  spring = "easy",         style = "popin 90%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 2,    bezier = "quick",        style = "popin 90%" })

-- Fades
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.5,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.2,  bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2.5,  bezier = "quick" })

-- Layers / menus
hl.animation({ leaf = "layers",        enabled = true, speed = 2.8,  bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 2.5,  bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "quick",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.5,  bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.2,  bezier = "almostLinear" })

-- Workspaces
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3,    bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.5,  bezier = "easeOutQuint",   style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5,  bezier = "quick",          style = "slide" })

-- Zoom
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 5,    bezier = "quick" })
