local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local UserInputService = game:GetService("UserInputService")
local function sendFakeInput()
    local camera = workspace.CurrentCamera
    camera.CFrame = camera.CFrame * CFrame.Angles(0, 0.001, 0)
end
local afkEnabled = false
local player = game.Players.LocalPlayer
local interval = 10 * 60
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
Section:NewSlider("เดินเร็ว 16-500", "SliderInfo", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
-- Drag System (แข็งที่สุด)
local UIS = game:GetService("UserInputService")

local function makeDraggable(frame)
    local dragging, dragInput, startPos, startMousePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startMousePos = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - startMousePos
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end


-- หา frame ใหญ่ที่สุดเพื่อลาก (โคตรชัวร์)
task.wait(1)
local main = game.CoreGui["NUNU PRO"]:FindFirstChild("Main")

if main then
    makeDraggable(main)
    print("Dragging Enabled on: Main")
else
    warn("Main frame not found!")
end
