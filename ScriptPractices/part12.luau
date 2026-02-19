local part = script.Parent

-- Add particle emitter to part
local particles = Instance.new("ParticleEmitter")
particles.Parent = part

-- Basic Settings
particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
particles.Rate = 50 -- Particles per second
particles.Lifetime = NumberRange.new(2, 4) -- 2-4 seconds
particles.Speed = NumberRange.new(2, 5) -- Speed range
particles.SpreadAngle = Vector2.new(360, 360) -- Spread in all dirns

local colorList = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),    -- Red at start
	ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 0)),  -- Yellow at middle
	ColorSequenceKeypoint.new(1, Color3.new(1, 0, 1))	  -- Purple at end
}

particles.Color = colorList

-- Make it look magical
particles.LightEmission = 0.5  						-- Glow
particles.LightInfluence = 0   						-- Not affected by lighting
local sizeList = {
	NumberSequenceKeypoint.new(0, 0.2),				-- (time, value)
	NumberSequenceKeypoint.new(0.5, 0.2),
	NumberSequenceKeypoint.new(0.65, 0.5),
	NumberSequenceKeypoint.new(0.75, 0.9),
	NumberSequenceKeypoint.new(0.95, 0.5),
	NumberSequenceKeypoint.new(1, 0)
}

particles.Size = NumberSequence.new(sizeList) 		-- Particle size
particles.Transparency = NumberSequence.new(0.3)	-- Slightly Transparent

