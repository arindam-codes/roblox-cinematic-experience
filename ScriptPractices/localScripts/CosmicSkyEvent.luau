local cosmicSkyEvent = game.ReplicatedStorage:WaitForChild("CosmicSkyEvent")
local lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local atmosphere = lighting:WaitForChild("Atmosphere")


cosmicSkyEvent.OnClientEvent:Connect(function()
	
	-- reality fades (not disappears)
	TweenService:Create(atmosphere, TweenInfo.new(2), {
		Density = 0.15,
		Haze = 0.8
	}):Play()

	task.wait(2)
	
	-- Phase 1: remove old sky
	for _,v in ipairs(lighting:GetChildren()) do
		if v:IsA("Sky") then
			v:Destroy()
		end
	end
	
	-- Phase 3: Cosmic Sky
	local sky = Instance.new("Sky")
	sky.Name = "CosmicSky"
	
	sky.SkyboxBk = "rbxassetid://159454299"
	sky.SkyboxDn = "rbxassetid://159454296"
	sky.SkyboxFt = "rbxassetid://159454293"
	sky.SkyboxLf = "rbxassetid://159454286"
	sky.SkyboxRt = "rbxassetid://159454300"
	sky.SkyboxUp = "rbxassetid://159454288"

	sky.StarCount = 0
	sky.CelestialBodiesShown = false
	sky.Parent = lighting
	
	-- Phase 4: reveal stars
	-- universe stabilizes
	TweenService:Create(lighting, TweenInfo.new(5), {
		Brightness = 3.2,
		Ambient = Color3.fromRGB(120,120,170)
	}):Play()

	TweenService:Create(atmosphere, TweenInfo.new(5), {
		Density = 0.35,
		Color = Color3.fromRGB(170,170,255)
	}):Play()


	
end)
