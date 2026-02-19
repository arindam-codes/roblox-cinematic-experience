local darkSkyEvent = game.ReplicatedStorage:WaitForChild("DarkSkyEvent")
local destroyDarkSkyEvent = game.ReplicatedStorage:WaitForChild("destroyDarkSkyEvent")

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local lighting = game:GetService("Lighting")
local atmosphere = lighting:FindFirstChildOfClass("Atmosphere")

local darkSkyEnabled = true
local darkSkyEventConnection

-- DARK SKY EVENT
darkSkyEventConnection = darkSkyEvent.OnClientEvent:Connect(function()

	if not darkSkyEnabled then return end
	
	-- slow unnatural sunset (brain notices first)
	TweenService:Create(lighting, TweenInfo.new(8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		ClockTime = 3.5,
		Brightness = 1.3
	}):Play()


	-- THEN darkness creeps in
	task.delay(2, function()

		TweenService:Create(lighting, TweenInfo.new(6, Enum.EasingStyle.Sine), {
			ClockTime = 0,
			Brightness = 1,
			Ambient = Color3.fromRGB(10, 10, 25),
			OutdoorAmbient = Color3.fromRGB(5, 5, 15)
		}):Play()

		TweenService:Create(atmosphere, TweenInfo.new(6), {
			Density = 0.8,
			Color = Color3.fromRGB(20,20,40),
			Haze = 5
		}):Play()

	end)

end)

-- Cinematic Settings
local TRANSITION_TIME = 20 -- Long duration for smooth "opening"
local NEBULA_PURPLE = Color3.fromRGB(170, 170, 255) -- Matches your image glow
local MAGENTA_MIST = Color3.fromRGB(80, 60, 110) -- The "in-between" color

-- DESTROY / STOP DARK SKY
destroyDarkSkyEvent.OnClientEvent:Connect(function()
	darkSkyEnabled = false
	darkSkyEventConnection:Disconnect()
	print("Dark sky disabled")
	
	print("Reality stabilizing")

	-- Info for a very smooth, weighted opening
	local info = TweenInfo.new(TRANSITION_TIME, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

	-- 1. FOG COLOR PROGRESSION
	-- shiftin the fog into a purple int before it disappears
	-- this makes the "Nebula" feel like it's glowing behind the clouds
	TweenService:Create(atmosphere, info, {
		Density = 0.35,            -- Clears the view
		Haze = 0.5,                -- Keeps a tiny bit of "glow" around stars
		Color = NEBULA_PURPLE,     -- The final sky color from your image
		Decay = Color3.fromRGB(40, 0, 60), -- Deep purple shadows in the distance
		Glare = 0.4                -- Adds that "star shimmer"
	}):Play()

	-- 2. LIGHTING & EXPOSURE
	-- this simulates the player's eyes adjusting to the bright nebula
	TweenService:Create(lighting, info, {
		ClockTime = 14,            -- or keep at 0/1 for space vibes
		Brightness = 3,            -- makes the purple nebula "pop"
		Ambient = Color3.fromRGB(60, 50, 80), -- subtle purple tint in shadows
		OutdoorAmbient = Color3.fromRGB(70, 60, 100),
		ExposureCompensation = 0.5 -- brightens the "glow" parts of the skybox
	}):Play()

	-- 3. THE "GLOW" (Bloom)
	local bloom = lighting:FindFirstChildOfClass("BloomEffect")
	if bloom then
		TweenService:Create(bloom, info, {
			Intensity = 1.2,
			Size = 40,
			Threshold = 0.85 -- only the brightest parts (stars/nebula) will glow
		}):Play()
	
	end
end)
