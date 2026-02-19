local pressedEvent = game.ReplicatedStorage:WaitForChild("HelloEvent")
local player = game.Players.LocalPlayer
local touchedPart = false

local part = Instance.new("Part")
part.Parent = workspace
part.Anchored = true
part.Position = Vector3.new(0,10,0)
part.Size = Vector3.new(1,1,1)
part.Color = Color3.fromRGB(0, 0, 0)


part.Touched:Connect(function()
	if touchedPart then return end
	pressedEvent:FireServer(" touched the part!") 
	touchedPart =  true
	task.wait(1)
	touchedPart = false
end)





