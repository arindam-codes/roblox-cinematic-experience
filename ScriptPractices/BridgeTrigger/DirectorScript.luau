local triggerPart = script.Parent
local event = game.ReplicatedStorage:WaitForChild("CutsceneEvent")
local darkSkyEvent = game.ReplicatedStorage:WaitForChild("DarkSkyEvent")
local cutsceneSync = game.ReplicatedStorage:WaitForChild("CutsceneSync")


local lighting = game:GetService("Lighting")
local atmosphere = lighting:WaitForChild("Atmosphere")
local activated = false
local heart_activated = false
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera
local portalEvent = game.ReplicatedStorage:WaitForChild("StartPortalSequence")
local portal = workspace:WaitForChild("Portal")
local Debris = game:GetService("Debris")


triggerPart.Touched:Connect(function(hit)
	
	if activated then return end -- Hard lock first
	
	local character = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	
	if not player then return end  -- Always check player before using Tocuhed bcz it can be tuched by anything particles or .. etc
								   -- so i want it will work only if that is a player 
	local humanoid = character:FindFirstChild("Humanoid")
	local humanoidRoot = character:WaitForChild("HumanoidRootPart")
	
	if humanoid and not activated then
		activated = true -- lock immediately
		-- tells only her client to start the cutscene
		
		-- Tell client to start camera cutscene
		event:FireClient(player)
		
		-- Player sees darkness fades in the sky 
		cutsceneSync.OnServerEvent:Connect(function(player, message)
			if message == "SkyFade" then
				darkSkyEvent:FireClient(player)
			end
		end)	
	end
end)


