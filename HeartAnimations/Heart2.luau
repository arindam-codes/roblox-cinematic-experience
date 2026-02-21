--// HEART 2


--// USER SETTINGS
local SETTINGS = {
	Text = "I started waiting for your messages...",
	Radius = 22
}

--// AUDIO SETTINGS
local Memory = require(game.ReplicatedStorage:WaitForChild("MemoryProgress"))


local PianoNotes = {
	"108021511258840", -- heart 1
	"71982470807187",  -- heart 2
	"96058691925396",  -- heart 3
	"134307215076263", -- heart 4
	"137670834275037", -- heart 5
	"132234660553562"  -- final heart
}

local HEART_NUMBER = 2


--// SERVICES & REFERENCES
local TweenService = game:GetService("TweenService")
local player = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local heart = script.Parent
local RADIUS = SETTINGS.Radius -- Size of invisible sphere
local heart_activated = false
--// PROXIMITY TRIGGER VOLUME

--------------------------------------------------
-- PROXIMITY CHECK LOOP
--------------------------------------------------

--// HEART ACTIVATION LOGIC
local connection
connection = RunService.Heartbeat:Connect(function()
	if heart_activated then 
		connection:Disconnect()
		return 
	end

	for _,theplayer in ipairs(player:GetPlayers()) do

		local character = theplayer.Character
		if not character then continue end

		local root = character:FindFirstChild("HumanoidRootPart")
		if not root then continue end

		local distance = (root.Position - heart.Position).Magnitude
		if distance <= RADIUS then
			heart_activated = true
			connection:Disconnect()
			print("Heart Activated (Proximity)")

			-- Create temporary blocker (Memory Fog Wall)
			local blocker = Instance.new("Part")
			blocker.Size = Vector3.new(60, 30, 2)
			blocker.Transparency = 1
			blocker.CastShadow = false
			blocker.TopSurface = Enum.SurfaceType.Smooth
			blocker.BottomSurface = Enum.SurfaceType.Smooth
			blocker.CanCollide = true
			blocker.Anchored = true
			blocker.CanQuery = false
			blocker.Name = "MemoryFog"
			blocker.Material = Enum.Material.SmoothPlastic
			blocker.Color = Color3.fromRGB(210, 210, 230)
			blocker.Parent = workspace

			-- Placing it slightly in front of heart
			local forward = heart.CFrame.LookVector
			local pos = heart.Position + forward * 6
			blocker.CFrame = CFrame.lookAt(pos, pos - forward)

			--Adding for particles
			local fog = Instance.new("ParticleEmitter")
			fog.Texture = "rbxasset://textures/particles/smoke_main.dds"
			fog.Size = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 10),
				NumberSequenceKeypoint.new(1, 14)
			}
			fog.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0.45),
				NumberSequenceKeypoint.new(0.6, 0.65),
				NumberSequenceKeypoint.new(1, 1)
			}

			-- Fog Density
			fog.Rate = 25

			-- Slow living fog
			fog.Lifetime = NumberRange.new(6, 9)

			-- Almost still
			fog.Speed = NumberRange.new(0.15, 0.35)

			-- Spread sideways like wall
			fog.SpreadAngle = Vector2.new(180, 20)

			-- Slow drifting rotation
			fog.Rotation = NumberRange.new(0, 360)
			fog.RotSpeed = NumberRange.new(-10, 10)

			-- For Atmosphere
			fog.LightInfluence = 0
			fog.Color = ColorSequence.new(Color3.fromRGB(160, 160, 190))

			fog.Shape = Enum.ParticleEmitterShape.Box
			fog.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
			fog.ShapeInOut = Enum.ParticleEmitterShapeInOut.Outward
			fog.EmissionDirection = Enum.NormalId.Front

			fog.Parent = blocker

			-- Heart Appearance
			heart.Material = Enum.Material.Neon
			heart.Transparency = 1
			local startPos = heart.Position - Vector3.new(0, 5, 0)

			-- Adding light in Heart
			heart.Position = startPos
			local light = Instance.new("PointLight")
			light.Color = Color3.fromRGB(255, 255, 255)
			light.Brightness = 0
			light.Range = 12
			light.Shadows = false
			light.Parent = heart

			-- Soft bloom pulse
			local Lighting = game:GetService("Lighting")
			local bloom = Lighting:FindFirstChildOfClass("BloomEffect")

			if not bloom then
				bloom = Instance.new("BloomEffect")
				bloom.Intensity = 0
				bloom.Size = 24
				bloom.Threshold = 1
				bloom.Parent = Lighting
			end

			local bloomInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			local bloomTween = TweenService:Create(bloom, bloomInfo, {
				Intensity = 0.6,
				Size = 30,
				Threshold = 0.9
			})
			bloomTween:Play()

			-- Adding BillBoardGui
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Size = UDim2.new(0, 300, 0, 120)
			billboardGui.StudsOffset = Vector3.new(0, 5.5, 0)
			billboardGui.Adornee = heart
			billboardGui.AlwaysOnTop = true
			billboardGui.Enabled = false
			billboardGui.Parent = script.Parent


			-- Adding TextLabel to BillboardGui
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Size = UDim2.new(1, 0, 1, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = SETTINGS.Text
			TextLabel.TextColor3 = Color3.fromRGB(255, 240, 230)
			TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 120, 160)
			TextLabel.TextStrokeTransparency = 0.4
			TextLabel.TextScaled = true
			TextLabel.Font = Enum.Font.GothamMedium
			TextLabel.TextSize = 18
			TextLabel.TextTransparency = 1
			TextLabel.Parent = billboardGui

			


			-- Sequence Start
			local info = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

			-- Rising and Glowing for pink light
			TweenService:Create(light, info, {Brightness = 2}):Play()
			TweenService:Create(heart, info, {
				Transparency = 0,
				Color = Color3.fromRGB(255, 90, 140),
				Size = heart.Size * 1.5,
				Position = heart.Position + Vector3.new(0, 5, 0),
				Orientation = heart.Orientation + Vector3.new(0, 360, 0)
			}):Play()

			task.wait(1.2)

			-- Show Text & Sound
			billboardGui.Enabled = true
			
			game.ReplicatedStorage.MemoryMoment:FireClient(theplayer, true)
			
			-- MEMORY PROGRESSION
			Memory.Current = math.max(Memory.Current, HEART_NUMBER)

			local volumeCurve = {0.25, 0.3, 0.38, 0.48, 0.65, 1}

			local piano = Instance.new("Sound")
			piano.SoundId = "rbxassetid://" .. PianoNotes[Memory.Current]
			piano.Volume = volumeCurve[Memory.Current]
			piano.RollOffMode = Enum.RollOffMode.Inverse
			piano.RollOffMinDistance = 10
			piano.RollOffMaxDistance = 60 + (Memory.Current * 25) -- gets louder across map
			piano.Parent = heart
			piano:Play()
			
			local guiInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			local textInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			TweenService:Create(billboardGui, guiInfo, {StudsOffset = Vector3.new(0, 4, 0)}):Play()
			TweenService:Create(TextLabel, TweenInfo.new(1.2, Enum.EasingStyle.Back), {TextSize = 24}):Play()
			TweenService:Create(TextLabel, textInfo, {TextTransparency = 0}):Play()

			task.wait(0.8)

			
			
			task.wait(0.6)

			-- Fade out UI
			TweenService:Create(TextLabel, TweenInfo.new(5), {TextTransparency = 1}):Play()

			-- Wait for text to fully disappear 
			task.wait(1.5)

			-- tiny emotional pause (important)
			task.wait(0.4)

			-- Memory Accepted (Golden Transformation)
			local awakenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)	

			local goldenGlow = Color3.fromRGB(255, 230, 130)

			TweenService:Create(heart, awakenInfo, {
				Color = goldenGlow,
				Position = heart.Position + Vector3.new(0, 8, 0),
				Size = heart.Size * 1.5, 
				Orientation = heart.Orientation + Vector3.new(0, 360, 0),
				Transparency = 0 
			}):Play()

			-- Transform light to MAX
			local lightTween = TweenService:Create(light, awakenInfo, {
				Color = Color3.fromRGB(255, 255, 200),
				Brightness = 15,
				Range = 40
			})
			lightTween:Play()

			-- Intense bloom peak
			local intenseBloom = TweenService:Create(bloom, TweenInfo.new(1), {
				Intensity = 3,
				Size = 30,
				Threshold = 0.5 
			})
			intenseBloom:Play()

			-- Golden aura (visible in fog)
			local aura = Instance.new("ParticleEmitter")
			aura.Texture = "rbxassetid://241594419"
			aura.LightEmission = 1
			aura.LightInfluence = 0

			aura.Size = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 5),
				NumberSequenceKeypoint.new(1, 9)
			}

			aura.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.15),
				NumberSequenceKeypoint.new(1, 1)
			}

			aura.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255,230,150)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255,170,80))
			}

			aura.Rate = 20
			aura.Lifetime = NumberRange.new(1.5,2.5)
			aura.Speed = NumberRange.new(0)
			aura.RotSpeed = NumberRange.new(-35,35)

			aura.Parent = heart

			-- Spark burst
			local spark = aura:Clone()
			spark.Rate = 50
			spark.Speed = NumberRange.new(5, 10)
			spark.SpreadAngle = Vector2.new(360, 360)
			spark.Parent = heart
			task.delay(1, function() spark.Enabled = false end)

			-- Wait for light to reach max brightness
			lightTween.Completed:Wait()

			-- Settle bloom to gentle pulse
			TweenService:Create(bloom, TweenInfo.new(2), {
				Intensity = 2,
				Size = 45,
				Threshold = 0.65
			}):Play()

			-- Start light pulsing (from 15 down to 8 and back up)
			task.spawn(function()
				while heart.Parent do
					-- Pulse down to 8
					local pulseDown = TweenService:Create(light, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Brightness = 8})
					pulseDown:Play()
					pulseDown.Completed:Wait()

					-- Pulse up to 15
					local pulseUp = TweenService:Create(light, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Brightness = 15})
					pulseUp:Play()
					pulseUp.Completed:Wait()
				end
			end)

			task.delay(6, function()
				TweenService:Create(bloom, TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Intensity = 0.8,
					Size = 24,
					Threshold = 1
				}):Play()

				TweenService:Create(light, TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					Brightness = 6
				}):Play()
			end)

			task.wait(0.2)
			if blocker then
				fog.Enabled = false
				local fade = TweenService:Create(blocker, TweenInfo.new(2.5), {Transparency = 1})
				fade:Play()

				-- Fading out the heart
				local heartFade = TweenService:Create(heart, TweenInfo.new(2), {Transparency = 1})
				heartFade:Play()

				-- Cleaning up the heart
				
				
				Debris:AddItem(blocker, 0.2) -- Cleans up the part and fog safely
				Debris:AddItem(heart, 0.7)
				heartFade.Completed:Wait()
				game.ReplicatedStorage.MemoryMoment:FireClient(theplayer, false)

				return

			end
		end
	end
end)
