local preCosmicEvent = game.ReplicatedStorage:WaitForChild("PreCosmicEvent")

preCosmicEvent.OnClientEvent:Connect(function()

	local TweenService = game:GetService("TweenService")
	local lighting = game:GetService("Lighting")
	local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")

	-- distant universe appears first (not brightness)
	TweenService:Create(atmosphere, TweenInfo.new(10, Enum.EasingStyle.Sine), {
		Density = 0.45,
		Haze = 2.2,
		Color = Color3.fromRGB(70,70,110),
		Decay = Color3.fromRGB(5,5,25)
	}):Play()

	-- stars barely visible BEFORE sky changes
	task.delay(3, function()
		TweenService:Create(lighting, TweenInfo.new(6), {
			Brightness = 2.4,
			OutdoorAmbient = Color3.fromRGB(90,90,140)
		}):Play()
	end)
end)
