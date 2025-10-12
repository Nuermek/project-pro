local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local plrGui = player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", plrGui)
local Frame1 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

Frame1.Parent = ScreenGui
Frame1.Position = UDim2.new(0.434, 0, 0.518, 0)
Frame1.Size = UDim2.new(0.22, 0, 0.22, 0)
Frame1.BackgroundColor3 = Color3.fromRGB(56,56,56)
Frame1.BackgroundTransparency = 0.3

TextButton.Parent = Frame1
TextButton.Size = UDim2.new(1, 0, 0.6, 0)
TextButton.Position = UDim2.new(0, 0, 0.4, 0)
TextButton.Text = "Scan : Off"
TextButton.TextScaled = true
TextButton.BackgroundColor3 = Color3.fromRGB(142, 118, 255)
TextButton.TextColor3 = Color3.new(1, 1, 1)

CloseButton.Parent = Frame1
CloseButton.Size = UDim2.new(0.18, 0, 0.4, 0)
CloseButton.Position = UDim2.new(0.82, 0, 0, 0)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 52, 52)
CloseButton.TextColor3 = Color3.new(0, 0, 0)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Run = false
TextButton.MouseButton1Click:Connect(function()
	if Run then
		Run = false
		TextButton.Text = "Scan : Off"
	else
		Run = true
		TextButton.Text = "Scan : On"
	end
end)

task.spawn(function()
	while task.wait(1) do
		if Run then
			local npc = workspace:FindFirstChild("Zombie")
			if npc then
				local humanoid = npc:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid.Health > 0 then
					humanoid:TakeDamage(25)
					print("Zombie ถูกสแกน - ลดเลือด 25 เหลือ:", humanoid.Health)
				end
			end
		end
	end
end)
