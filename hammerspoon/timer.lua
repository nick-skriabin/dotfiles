-- Section 2: Setup
local hotkey = require("hs.hotkey")
local window = require("hs.window")
local timer = require("hs.timer")
local urlevent = require("hs.urlevent")
local alert = require("hs.alert")
local canvas = require("hs.canvas")

-- Section 3: UI Elements (moved up)
local displayUI = {
    canvas = nil,
    colors = {
        work = {
            active = { red = 0.2, green = 0.6, blue = 1, alpha = 0.9 },
            inactive = { red = 0.2, green = 0.6, blue = 1, alpha = 0.6 },
        },
        rest = {
            active = { red = 0.3, green = 0.8, blue = 0.3, alpha = 0.9 },
            inactive = { red = 0.3, green = 0.8, blue = 0.3, alpha = 0.6 },
        },
    },
}

local DEFAULT_DURATION = 25 * 60
local DEFAULT_BREAK = 5 * 60
local DEFAULT_LONG_BREAK = 15 * 60
local SESSIONS_STREAK = 4

local function formatTime(time)
    local minutes = math.floor(time / 60)
    local seconds = time % 60

    return string.format("%02d:%02d", minutes, seconds)
end

function displayUI:setup()
    local screen = hs.screen.primaryScreen()
    local frame = screen:frame()

    -- Create canvas for our UI
    self.canvas = canvas.new({
        x = frame.w - 180,
        y = frame.h - 80,
        w = 170,
        h = 70, -- Increased height
    })

    -- Add background rectangle
    self.canvas[1] = {
        type = "rectangle",
        action = "fill",
        roundedRectRadii = { xRadius = 10, yRadius = 10 },
        fillColor = self.colors.work.inactive,
    }

    -- Add timer text
    self.canvas[2] = {
        type = "text",
        frame = { x = 0, y = 10, w = 170, h = 30 }, -- Positioned at top
        text = formatTime(DEFAULT_DURATION),
        textFont = "SFMono-Regular",
        textSize = 24,
        textColor = { hex = "#FFFFFF" },
        textAlignment = "center",
    }

    -- Add session info text
    self.canvas[3] = {
        type = "text",
        frame = { x = 0, y = 45, w = 170, h = 20 }, -- Positioned below timer
        text = "Work Session 1/" .. SESSIONS_STREAK,
        textFont = "SFMono-Regular",
        textSize = 12,
        textColor = { hex = "#FFFFFF", alpha = 0.8 },
        textAlignment = "center",
    }

    self.canvas:show()
end

function displayUI:setMode(mode, isWorkSession)
    if not self.canvas then
        return
    end
    local colors = isWorkSession and self.colors.work or self.colors.rest
    self.canvas[1].fillColor = colors[mode]
end

-- Section 4: Timer Implementation
local focusTimer = {
    -- Pomodoro settings
    workDuration = DEFAULT_DURATION,
    shortBreakDuration = DEFAULT_BREAK,
    longBreakDuration = DEFAULT_LONG_BREAK,
    sessionsUntilLongBreak = SESSIONS_STREAK,

    -- State tracking
    timeLeft = DEFAULT_DURATION,
    isRunning = false,
    timer = nil,
    savedWindows = {},
    currentSession = 1,
    isWorkSession = true,
    sessionHistory = {},

    -- Statistics
    completedSessions = 0,
    totalWorkTime = 0,
}

function displayUI:toggle()
    if not self.canvas then
        return
    end

    self.isVisible = not self.isVisible
    if self.isVisible then
        self.canvas:show()
    else
        self.canvas:hide()
    end
end

function displayUI:show()
    if not self.canvas then
        return
    end
    self.isVisible = true
    self.canvas:show()
end

function displayUI:hide()
    if not self.canvas then
        return
    end
    self.isVisible = false
    self.canvas:hide()
end

function focusTimer:updateDisplay()
    if not displayUI.canvas then
        return
    end

    local displayText = formatTime(self.timeLeft)

    -- Update timer text
    displayUI.canvas[2].text = displayText

    -- Update session info text
    local sessionText = self.isWorkSession and string.format("Work Session %d/%d", self.currentSession, self.sessionsUntilLongBreak)
        or (self:isLongBreakDue() and "Long Rest" or "Short Rest")
    displayUI.canvas[3].text = sessionText

    local displayText = formatTime(self.timeLeft)

    -- Update timer text
    displayUI.canvas[2].text = displayText

    -- Update session info text
    local sessionText = self.isWorkSession and string.format("Work Session %d/%d", self.currentSession, self.sessionsUntilLongBreak)
        or (self:isLongBreakDue() and "Long Rest" or "Short Rest")
    displayUI.canvas[3].text = sessionText
end

function focusTimer:start()
    if self.isRunning then
        return
    end

    self.isRunning = true
    -- Set duration based on current session type
    if self.isWorkSession then
        self.timeLeft = self.workDuration
    else
        self.timeLeft = self:isLongBreakDue() and self.longBreakDuration or self.shortBreakDuration
    end

    -- Create repeating timer
    self.timer = timer.doEvery(1, function()
        self:tick()
    end)

    -- Only manage windows during work sessions
    if self.isWorkSession then
        self:captureCurrentLayout()
        self:enterFocusMode()
    end

    self:updateDisplay()
    displayUI:setMode("active", self.isWorkSession)
end

function focusTimer:stop()
    if not self.isRunning then
        return
    end

    self.isRunning = false
    if self.timer then
        self.timer:stop()
        self.timer = nil
    end

    -- Only restore windows if we're in a work session
    if self.isWorkSession then
        self:restoreLayout()
    end

    displayUI:setMode("inactive", self.isWorkSession)
end

function focusTimer:tick()
    self.timeLeft = self.timeLeft - 1

    if self.isWorkSession then
        self.totalWorkTime = self.totalWorkTime + 1
    end

    self:updateDisplay()

    if self.timeLeft <= 0 then
        self:completeSession()
    end
end

function focusTimer:notifyCompletion()
    if self.isWorkSession then
        if self:isLongBreakDue() then
            alert.show("Time for a long rest!", 2)
        else
            alert.show("Time for a short rest!", 2)
        end
    else
        alert.show("Rest complete! Ready to focus?", 2)
    end
end

function focusTimer:completeSession()
    self:stop()

    if self.isWorkSession then
        self.completedSessions = self.completedSessions + 1
        table.insert(self.sessionHistory, {
            type = "work",
            duration = self.workDuration,
            timestamp = os.time(),
        })

        -- Determine next break type
        if self:isLongBreakDue() then
            self.currentSession = 1
        else
            self.currentSession = self.currentSession + 1
        end
    else
        table.insert(self.sessionHistory, {
            type = "rest",
            duration = self:isLongBreakDue() and self.longBreakDuration or self.shortBreakDuration,
            timestamp = os.time(),
        })
    end

    self:notifyCompletion()

    -- Toggle session type
    self.isWorkSession = not self.isWorkSession
    self:updateDisplay()
end

function focusTimer:isLongBreakDue()
    return self.currentSession >= self.sessionsUntilLongBreak
end

function focusTimer:skip()
    if self.isRunning then
        self:completeSession()
    end
end

function focusTimer:getStats()
    return {
        completedSessions = self.completedSessions,
        totalWorkTime = self.totalWorkTime,
        currentStreak = #self.sessionHistory,
    }
end

-- Section 5: Window Management
function focusTimer:captureCurrentLayout()
    self.savedWindows = {}
    local allWindows = window.allWindows()

    for _, win in ipairs(allWindows) do
        if win:isVisible() then
            table.insert(self.savedWindows, {
                window = win,
                frame = win:frame():copy(),
            })
        end
    end
end

function focusTimer:enterFocusMode()
    local focused = window.focusedWindow()
    if focused and focused:isVisible() then
        local screen = focused:screen():frame()
        focused:setFrame(screen)
    end
end

function focusTimer:restoreLayout()
    for _, winInfo in ipairs(self.savedWindows) do
        if winInfo.window and winInfo.window:isVisible() then
            winInfo.window:setFrame(winInfo.frame)
        end
    end
end

-- Section 6: Website Blocking
local blockedDomains = {
    "reddit.com",
    "twitter.com",
    "facebook.com",
    "instagram.com",
}

local function setupUrlBlocking()
    urlevent.httpCallback = function(scheme, host, params, fullUrl)
        if not focusTimer.isRunning then
            return true
        end

        for _, domain in ipairs(blockedDomains) do
            if string.find(host, domain) then
                alert.show("Site blocked during focus session", 2)
                return false
            end
        end
        return true
    end
end

-- Final setup and hotkey binding
local function init()
    displayUI:setup()
    setupUrlBlocking()

    -- Bind main hotkey (CMD+ALT+F)
    hotkey.bind({ "cmd", "alt" }, "F", function()
        if focusTimer.isRunning then
            focusTimer:stop()
        else
            focusTimer:start()
        end
    end)

    -- Bind toggle visibility hotkey (CMD+ALT+V)
    hotkey.bind({ "cmd", "alt" }, "V", function()
        displayUI:toggle()
    end)

    -- Bind skip hotkey (CMD+ALT+S)
    hotkey.bind({ "cmd", "alt" }, "S", function()
        focusTimer:skip()
    end)

    -- Bind stats hotkey (CMD+ALT+T)
    hotkey.bind({ "cmd", "alt" }, "T", function()
        local stats = focusTimer:getStats()
        alert.show(
            string.format(
                "Sessions: %d\nTotal Work Time: %d mins\nCurrent Streak: %d",
                stats.completedSessions,
                math.floor(stats.totalWorkTime / 60),
                stats.currentStreak
            ),
            3
        )
    end)
end

init()
