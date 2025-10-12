local UIS = game:GetService("UserInputService")
local runtimeItems = workspace:WaitForChild("RuntimeItems")
local replicatedStorage = game:GetService("ReplicatedStorage")
local storeItemRemote = replicatedStorage:WaitForChild("Remotes"):WaitForChild("StoreItem")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
 
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local plrGui = Plr.PlayerGui
 
local ScreenGui = Instance.new("ScreenGui")
local Frame1 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
 
task.wait(0.1)
 
Frame1.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame1.Position
    end
end)
 
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame1.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
 
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
 
ScreenGui.Parent = plrGui
Frame1.Parent = ScreenGui
 
Frame1.Position = UDim2.new(0.434, 0,0.518, 0)
Frame1.Size = UDim2.new(0.22, 0,0.22, 0)
Frame1.Interactable = true
 
local NewUIStroke = Instance.new("UIStroke")
 
Frame1.BackgroundColor3 = Color3.new(0.219608, 0.219608, 0.219608)
Frame1.BackgroundTransparency = 0.5
Frame1.BorderSizePixel = 5
Frame1.BorderColor3 = Color3.new(0.0509804, 0, 0.164706)
 
TextButton.Parent = Frame1
TextButton.Size = UDim2.new(1, 0,0.60, 0)
TextButton.Position = UDim2.new(0, 0,0.4, 0)
TextButton.TextScaled = true
TextButton.BackgroundColor3 = Color3.new(0.556863, 0.466667, 1)
NewUIStroke.Parent = TextButton
NewUIStroke.Color = Color3.new(0.117647, 0.117647, 0.117647)
NewUIStroke.Thickness = 2
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.Text = "Scan : off"
 
local ClosBut = Instance.new("TextButton")
ClosBut.Parent = Frame1
 
ClosBut.Size = UDim2.new(0.18, 0,0.4, 0)
ClosBut.Position = UDim2.new(0.82, 0,0, 0)
ClosBut.TextScaled = true
ClosBut.BackgroundColor3 = Color3.new(1, 0.203922, 0.203922)
ClosBut.TextColor3 = Color3.new(0, 0, 0)
ClosBut.Text = "X"
 
local Run = false
 
TextButton.TouchTap:Connect(function()
    if TextButton.Text == "Scan : On" then
        TextButton.Text = "Scan : Off"
        Run = false
    else
        TextButton.Text = "Scan : On"
        Run = true
    end
end)
 
ClosBut.TouchTap:Connect(function()
    ClosBut.Visible = false
    TextButton.Text = " ขอคุณที่ใช้สคริปครับ Create by Somtank "
    local Bye = Instance.new("Sound")
    Bye.Parent = game.SoundService
    Bye.SoundId = "rbxassetid://154157386"
    Bye:Play()
    task.wait(1)
    Bye:Destroy()
    ScreenGui:Destroy()
end)
 
 
 
task.spawn(function()
    while true do
        if Run then
            for _, model in ipairs(runtimeItems:GetChildren()) do
                if model:IsA("Model") then
                    local tooFar = false
                    for _, part in ipairs(model:GetDescendants()) do
                        if part:IsA("Part") or part:IsA("MeshPart") or part:IsA("UnionOperation") then
                            if character.PrimaryPart then
                                local distance = (part.Position - character.PrimaryPart.Position).Magnitude
                                if distance > 10 then
                                    tooFar = true
                                    break
                                end
                            end
                        end
                    end
 
                    if tooFar then
                        if not model:FindFirstChildOfClass("Highlight") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = model
                            highlight.FillTransparency = 0.5
                            highlight.FillColor = Color3.new(1, 1, 1)
                            highlight.OutlineTransparency = 1
                        end
                    else
                        storeItemRemote:FireServer(model)
                    end
                end
            end
        end
        task.wait(0.01)  -- หน่วงเวลาเพื่อลดภาระ CPU
    end
end)
