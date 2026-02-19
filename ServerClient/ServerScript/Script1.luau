local event = game.ReplicatedStorage:WaitForChild("HelloEvent")
local player = game:GetService("Players")

event.OnServerEvent:Connect(function(player, message)
	print(player.Name .. message)
end)
