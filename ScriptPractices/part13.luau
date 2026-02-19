-- Create sound
local sound = Instance.new("Sound")
sound.Parent = game:GetService("SoundService")  -- or attach to a part

-- Properties
sound.SoundId = "rbxassetid://IDneededhere"  -- Sound ID from Roblox
sound.Volume = 0.5
sound.Looped = true 	  -- Repeat forever
sound.PlaybackSpeed = 1   -- Normal speed

-- Control sound

sound:Play()	-- Start playing
--[[
sound:Pause()   -- Pause
sound:Stop()	-- Stop
sound:Resume()	-- Resume after pause
]]
-- Check if playing
if sound.IsPlaying then
	print("Sound is playing")
end
