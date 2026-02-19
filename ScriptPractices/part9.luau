-- Get all players
local players = game:GetService("Players")
local allPlayers = players:GetPlayers()

-- When player joins
players.PlayerAdded:Connect(function(player)
	print(player.Name .. " joined the game!")
end)

-- When player leaves
players.PlayerRemoving:Connect(function(player)
	print(player.Name .. " Left")
end)

-- Get player from charecter (when something touches them)
local function onTouch(hit)
	local charecter = hit.Parent
	local player = players:GetPlayerFromCharecter(charecter)
	
	if player then
		print("Touched by: " .. player.Name)
	end
end

-- Player Properties
print(player.Name)
print(player.UserId)
print(player.DisplayName)
