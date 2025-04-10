--- This script is designed to be used along with ZSA's Keymapp app
---
--- Things it does:
--- - checks if Keymapp is running and launches it if not
--- - sends signal to the keyboard to switch to a specified layer
--- - layer is always attached to a specific layout: by default it's QWERTY layer with Russian layout, and Graphite for the U.S. layout

local KEYBOARD_NAME = "Voyager"
local KEYBOARD_CONNECTED = false

local alert_colors = {
    alert = {
        stroke = { white = 1, alpha = 0 },
        background = { hex = "#1e1e2e", alpha = 1 },
        text = { hex = "#cdd6f4", alpha = 1 },
    },
}

function Alert(message)
    hs.alert.closeAll()
    hs.alert.show(message, {
        textColor = alert_colors.alert.text,
        fillColor = alert_colors.alert.background,
        strokeColor = alert_colors.alert.stroke,
        textSize = 12,
        radius = 4,
        atScreenEdge = 2,
        padding = 12,
    }, hs.screen.mainScreen(), 2)
end

local LAYOUTS = {
    qwerty_us = "com.apple.keylayout.US",
    qwerty_ru = "com.apple.keylayout.RussianWin",
}

local layout_names = {
    [LAYOUTS.qwerty_us] = "US",
    [LAYOUTS.qwerty_ru] = "RU",
}

--- Check if the keypoard is connected
local function check_connection()
    KEYBOARD_CONNECTED = false
    local devices = hs.usb.attachedDevices()
    for _, v in pairs(devices) do
        if v.productName == KEYBOARD_NAME then
            KEYBOARD_CONNECTED = true
            break
        end
    end
end

local function set_layout(layout)
    hs.keycodes.currentSourceID(layout)
    Alert("Layout: " .. layout_names[layout])
end

-- Will toggle between RU and EN QWERTY
local function toggle_layout()
    local current_layout = hs.keycodes.currentSourceID()
    local new_source = LAYOUTS.qwerty_ru
    local layout = LAYOUTS.qwerty_us

    if current_layout ~= layout then
        new_source = layout
    end
    set_layout(new_source)
    return new_source
end

local function toggle_layer(layout)
    local index = 0
    if layout ~= LAYOUTS.qwerty_ru then
        index = 1
    end
    local cmd = "/bin/zsh -c 'kontroll set-layer --index " .. index .. "'"
    print("setting layer " .. index .. " for layout " .. layout)
    print(cmd)
    print(hs.execute(cmd))
end

--- Watch for USB connections
local usb_watcher = hs.usb.watcher.new(function(data)
    check_connection()
end)
usb_watcher:start()

--- Keymaps
---
--- Binds a cmd+space (standard macOS hotkey for switching layouts)
--- It will be used instead of system's one
hs.hotkey.bind({ "cmd" }, "space", function()
    check_connection()
    local layout = toggle_layout()
    toggle_layer(layout)
end)
