
------------------
---- MONITORS ----
------------------

hl.monitor({
    output    = "eDP-1",
    mode      = "1920x1080@60",
    position  = "auto",
    scale     = "1",
})

hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@100",
    position  = "auto",
    scale     = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal     = "kitty"
local fileManager  = "nemo"
local menu         = "rofi -show drun"
local browser      = "firefox"
local code         = "subl"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

local colors = require("colors")

hl.config({
    general = {
        gaps_in   = 5,
        gaps_out  = 10,

        border_size = 2,

        col = {
            active_border   = { colors = {colors.primary, colors.secondary}, angle = 45 },
            inactive_border = colors.outline,
        },

        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding        = 0,
        rounding_power  = 0,

        active_opacity    = 1.0,
        inactive_opacity  = 1.0,

        shadow = {
            enabled       = true,
            range         = 4,
            render_power  = 3,
            color         = colors.shadow,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        force_split     = 2,
        preserve_split  = true,
        smart_split     = false,
    },

    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = false,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout   = "us",
        kb_variant  = "",
        kb_model    = "",
        kb_options  = "",
        kb_rules    = "",

        follow_mouse = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers    = 3,
    direction  = "horizontal",
    action     = "workspace"
})

hl.device({
    name         = "wacom-one-pen-tablet-small",
    output       = "HDMI-A-1"
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/wifi.sh"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/powerprofile.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/hypr/scripts/clipboard.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("killall -9 waybar; waybar &"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd([[ grim -o "$(hyprctl activeworkspace -j | jq -r '.monitor')" - | wl-copy && notify-send -t 3000 "Clipboard" "Screenshot Copied to clipboard! 📋" ]]))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd([[ grim -g "$(slurp)" - | wl-copy && notify-send -t 3000 "Clipboard" "Screenshot Copied to clipboard! 📋" ]]))

hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + C",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    name   = "suppress-maximize-events",
    match  = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name   = "fix-xwayland-drags",
    match  = {
        class       = "^$",
        title       = "^$",
        xwayland    = true,
        float       = true,
        fullscreen  = false,
        pin         = false,
    },

    no_focus = true,
})

hl.window_rule ({
    name   = "imv",
    match  = {
        class = "^(imv)$",
    },
    float   = true,
    center  = true,
    size    = "1080 720",
    dim_around = true,
})

hl.window_rule ({
    name   = "mpv",
    match  = {
        class = "^(mpv)$",
    },
    float   = true,
    center  = true,
    size    = "1080 720",
    dim_around = true,
})

hl.window_rule ({
    name   = "xdg-desktop-portal-gtk",
    match  = {
        class = "^(xdg-desktop-portal-gtk)$",
    },
    float   = true,
    center  = true,
    size    = "900 500",
    dim_around = true,
})

hl.window_rule ({
    name   = "hyprland-share-picker",
    match  = {
        class = "^(hyprland-share-picker)$",
    },
    float   = true,
    center  = true,
    size    = "900 700",
    dim_around = true,
})

hl.window_rule ({
    name   = "nemo",
    match  = {
        class = "^(nemo)$",
    },
    float   = true,
    center  = true,
    size    = "900 600",
    dim_around = true,
})

hl.window_rule ({
    name   = "zathura",
    match  = {
        class = "^(org.pwmt.zathura)$",
    },
    float   = true,
    center  = true,
    size    = "1200 1000",
    dim_around = true,
})

hl.layer_rule ({
    name   = "rofi-effects",
    match  = {
        namespace = "^(rofi)$",
    },
    dim_around = true,
    animation = "popin",
})