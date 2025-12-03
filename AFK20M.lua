local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local UserInputService = game:GetService("UserInputService")
local function sendFakeInput()
    local camera = workspace.CurrentCamera
    camera.CFrame = camera.CFrame * CFrame.Angles(0, 0.001, 0) -- หมุนกล้องเล็ก ๆ
end
local afkEnabled = false
local player = game.Players.LocalPlayer
local moveDistance = 0.2       -- ระยะที่ให้ขึ้น (stud)
local interval = 10 * 60       -- 10 นาที (600 วินาที)
local Window = Library.CreateLib("NUNU PRO", "DarkTheme")
local Tab = Window:NewTab("basic")
local Section = Tab:NewSection("afk")
spawn(function()
    while true do
        wait(interval)
        if afkEnabled then
            sendFakeInput()
        end
    end
end)
Section:NewToggle("afk", "ToggleInfo", function(state)
    afkEnabled = state
    if afkEnabled then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)
Section:NewSlider("เดินเร็ว 0-500", "SliderInfo", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
