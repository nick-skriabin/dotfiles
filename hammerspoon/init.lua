require("hs.ipc")
hs.loadSpoon("ReloadConfiguration")

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
local colors = {
    alert = {
        stroke = { white = 1, alpha = 0 },
        background = { hex = cattpuccin.base, alpha = 1 },
        text = { hex = cattpuccin.text, alpha = 1 },
    },
}

function Alert(message)
    hs.alert.closeAll()
    hs.alert.show(message, {
        textColor = colors.alert.text,
        fillColor = colors.alert.background,
        strokeColor = colors.alert.stroke,
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

local default_layout = layouts.colemak

spoon.ReloadConfiguration:start()

local ext_keyboard = false

local keyboard_name = "Voyager"

local function set_layout(layout)
    hs.keycodes.currentSourceID(layout)
    Alert("Layout: " .. layout_names[layout])
end

local function set_initial()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.qwerty_ru then
        return
    end

    if ext_keyboard then
        set_layout(default_layout)
    else
        set_layout(layouts.qwerty_us)
    end
end

local function toggle_qw()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.qwerty_us then
        set_layout(layouts.qwerty_ru)
    else
        set_layout(layouts.qwerty_us)
    end
end

local function toggle_col()
    local current_layout = hs.keycodes.currentSourceID()
    if current_layout == layouts.colemak then
        set_layout(layouts.qwerty_ru)
    else
        set_layout(default_layout)
    end
end

local function default_scan_keyboards(set_layout)
    ext_keyboard = false
    local devices = hs.usb.attachedDevices()
    for _, v in pairs(devices) do
        if v.productName == keyboard_name then
            ext_keyboard = true
            break
        end
    end
    if set_layout ~= false then
        set_initial()
    end
end

hs.hotkey.bind({ "cmd" }, "space", function()
    default_scan_keyboards(false)
    if ext_keyboard then
        toggle_col()
    else
        toggle_qw()
    end
end)

local usb_watcher = hs.usb.watcher.new(function(data)
    if data["productName"] ~= keyboard_name then
        return
    end

    if data["eventType"] == "added" then
        ext_keyboard = true
        caps:stop()
    elseif data["eventType"] == "removed" then
        ext_keyboard = false
        caps:start()
    end

    set_initial()
end)
usb_watcher:start()

default_scan_keyboards()
