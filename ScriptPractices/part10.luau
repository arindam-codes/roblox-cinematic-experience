-- TOUCH event (when something touches a part)
local part = script.Parent

local function onTouch(hit)
	print("Something touched me!")
	print("The thing that touched: " .. hit.Name)
end

part.Touched:Connect(onTouch)

-- SHORTER version (same thing)
part.Touched:Connect(function(hit)
	print("Touched by: " .. hit.Name)
end)

-- HEARTBEAT (runs every frame ~60 times/second)
game:GetService("RunService").HEARTBEAT:Connect(function(dt)
	-- HEARTBEAT = game's pulse
	-- dt = how long btw heartbeats
end)
