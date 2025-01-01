require("hs.ipc")
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("ControlEscape")
spoon.ReloadConfiguration:start()

hs.ipc.cliInstall("$HOME/.bin")

local caps = hs.spoons.ControlEscape

local cattpuccin = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
}

local alert_colors = {
    alert = {
        stroke = { white = 1, alpha = 0 },
        background = { hex = cattpuccin.base, alpha = 1 },
        text = { hex = cattpuccin.text, alpha = 1 },
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

local layouts = {
    qwerty_us = "com.apple.keylayout.US",
    qwerty_ru = "com.apple.keylayout.RussianWin",
    colemak = "io.github.colemakmods.keyboardlayout.colemakdh.colemakdhansi",
    graphite = "org.sil.ukelele.keyboardlayout.graphite.graphite",
}

local layout_names = {
    [layouts.qwerty_us] = "US",
    [layouts.qwerty_ru] = "RU",
    [layouts.colemak] = "Colemak",
    [layouts.graphite] = "Graphite",
}

local DEFAULT_LAYOUT = layouts.colemak

local EXT_KEYBOARD = false

local KEYBOARD_NAME = "Voyager"

local function set_layout(layout)
    hs.keycodes.currentSourceID(layout)
    Alert("Layout: " .. layout_names[layout])
end

-- Sets an initial keyboard layout based on
-- whether there's an external keyboard is
-- connected
local function set_initial()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.qwerty_ru then
        return
    end

    if EXT_KEYBOARD then
        set_layout(DEFAULT_LAYOUT)
        spoon.ControlEscape:stop()
    else
        set_layout(layouts.qwerty_us)
        spoon.ControlEscape:start()
    end
end

-- Will toggle between RU and EN QWERTY
local function toggle_qwerty()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.qwerty_us then
        set_layout(layouts.qwerty_ru)
    else
        set_layout(layouts.qwerty_us)
    end
end

-- Will toggle between QWERTY for cyrilic and Colemak for English
local function toggle_colemak()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.colemak then
        set_layout(layouts.qwerty_ru)
    else
        set_layout(DEFAULT_LAYOUT)
    end
end

-- Runs a default USB scan to check if an external device
-- with KEYBOARD_NAME is connected. If so, will activate
-- Colemak layout.
local function default_scan_keyboards(layout)
    EXT_KEYBOARD = false
    local devices = hs.usb.attachedDevices()
    for _, v in pairs(devices) do
        if v.productName == KEYBOARD_NAME then
            EXT_KEYBOARD = true
            break
        end
    end
    if layout ~= false then
        set_initial()
    end
end

-- Does the same thing as `default_scan_keyboards` but
-- dynamically and reacts to added/removed USB devices.
local usb_watcher = hs.usb.watcher.new(function(data)
    if data["productName"] ~= KEYBOARD_NAME then
        return
    end

    if data["eventType"] == "added" then
        EXT_KEYBOARD = true
        set_initial()
    elseif data["eventType"] == "removed" then
        EXT_KEYBOARD = false
        set_initial()
    end

    set_initial()
end)
usb_watcher:start()

-- Initial keyboard/layout check.
default_scan_keyboards()

-- Keymaps
--
-- Binds a cmd+space (standard macOS hotkey for switching layouts)
-- It will be used instead of system's one
hs.hotkey.bind({ "cmd" }, "space", function()
    default_scan_keyboards(false)
    if EXT_KEYBOARD then
        toggle_colemak()
    else
        toggle_qwerty()
    end
end)
