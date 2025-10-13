local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local KILL_DISTANCE = 100
local DAMAGE = 1000
local killing = false
local humanoidRoot

local function getRoot()
	local char = player.Character or player.CharacterAdded:Wait()
	humanoidRoot = char:WaitForChild("HumanoidRootPart")
end
getRoot()
player.CharacterAdded:Connect(getRoot)

local function killNearbyNPCs()
	if not humanoidRoot then return end
	for _, model in pairs(workspace:GetChildren()) do
		if model:IsA("Model") and model ~= player.Character then
			local hum = model:FindFirstChildOfClass("Humanoid")
			local root = model:FindFirstChild("HumanoidRootPart")

			if hum and root and hum.Health > 0 then
				local dist = (root.Position - humanoidRoot.Position).Magnitude
				if dist <= KILL_DISTANCE then
					hum:TakeDamage(DAMAGE)
					print("Killed:", model.Name, "(", math.floor(dist), "studs )")
				end
			end
		end
	end
end

task.spawn(function()
	while task.wait(1) do
		if killing then
			pcall(killNearbyNPCs)
		end
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "KillNPCGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 130, 0, 50)
button.Position = UDim2.new(0, 30, 0, 150)
button.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "Kill: OFF"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.Parent = gui

local dragging = false
local dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = button.Position
	end
end)

button.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		input.Changed:Connect(function()
			if dragging and input.UserInputState == Enum.UserInputState.Change then
				update(input)
			end
		end)
	end
end)

button.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

button.MouseButton1Click:Connect(function()
	killing = not killing
	if killing then
		button.Text = "Kill: ON"
		button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	else
		button.Text = "Kill: OFF"
		button.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
	end
end)
