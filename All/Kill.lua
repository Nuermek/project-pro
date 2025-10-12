local npc = workspace:WaitForChild("Zombie")
local humanoid = npc:WaitForChild("Humanoid")

humanoid.Touched:Connect(function(hit)
	local tool = hit.Parent
	if tool and tool:FindFirstChild("IsWeapon") then
		humanoid:TakeDamage(100)
	end
end)
