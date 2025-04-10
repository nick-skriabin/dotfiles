hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("ControlEscape")
hs.loadSpoon("ZSALayoutSwitch")

-- By default, it will look for Voyager, if you're using Moonlander, uncomment this:
-- spoon.ZSALayoutSwitch:set_keyboard("Moonlander")

-- spoon.ZSALayoutSwitch:set_layers({
--     ["com.apple.keylayout.RussianWin"] = { layer = 0, title = "QWERTY" },
--     ["com.apple.keylayout.US"] = { layer = 1, title = "Graphite" },
-- })
--
-- spoon.ZSALayoutSwitch:start()

spoon.ReloadConfiguration:start()

require("layout-switch")
-- require("keymapp-switch")
-- require("timer")
