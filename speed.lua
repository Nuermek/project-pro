local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 160)
Frame.Position = UDim2.new(0.35, 0, 0.55, 0)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0.25, 0)
Title.BackgroundTransparency = 1
Title.Text = "🏃 Speed Controller"
Title.TextScaled = true
Title.TextColor3 = Color3.new(1, 1, 1)

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = Frame
SpeedBox.Size = UDim2.new(0.9, 0, 0.3, 0)
SpeedBox.Position = UDim2.new(0.05, 0, 0.3, 0)
SpeedBox.PlaceholderText = "พิมพ์เลขความเร็ว เช่น 50"
SpeedBox.TextScaled = true
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.BackgroundColor3 = Color3.fromRGB(90, 90, 255)

local ApplyButton = Instance.new("TextButton")
ApplyButton.Parent = Frame
ApplyButton.Size = UDim2.new(0.4, 0, 0.25, 0)
ApplyButton.Position = UDim2.new(0.05, 0, 0.65, 0)
ApplyButton.Text = "✅ ใช้"
ApplyButton.TextScaled = true
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

local ResetButton = Instance.new("TextButton")
ResetButton.Parent = Frame
ResetButton.Size = UDim2.new(0.4, 0, 0.25, 0)
ResetButton.Position = UDim2.new(0.55, 0, 0.65, 0)
ResetButton.Text = "❌ รีเซ็ต"
ResetButton.TextScaled = true
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local Info = Instance.new("TextLabel")
Info.Parent = Frame
Info.Size = UDim2.new(1, 0, 0.15, 0)
Info.Position = UDim2.new(0, 0, 0.85, 0)
Info.BackgroundTransparency = 1
Info.TextScaled = true
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.Text = "Speed: " .. humanoid.WalkSpeed

ApplyButton.MouseButton1Click:Connect(function()
	local num = tonumber(SpeedBox.Text)
	if num and num > 0 then
		humanoid.WalkSpeed = num
		Info.Text = "Speed: " .. num
	else
		Info.Text = "⚠️ ใส่เลขเท่านั้น!"
	end
end)

ResetButton.MouseButton1Click:Connect(function()
	humanoid.WalkSpeed = 16
	Info.Text = "Speed: 16"
	SpeedBox.Text = ""
end)

print("[✅ Speed GUI Loaded | Type number and press Apply]")
