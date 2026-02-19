local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
	
	-- Create screen GUI

	local gui = Instance.new("ScreenGui")
	gui.Parent = player.PlayerGui -- Attach to player's screen

	-- Create text label
	local text = Instance.new("TextLabel")
	text.Parent = gui
	text.Size = UDim2.new(0, 400, 0, 100) -- Width 400, Height 100
	text.Position = UDim2.new(0.5, -200, 0.3, 0) -- Center horizontally
	text.BackgroundTransparency = 1 -- Invisible background
	text.TextColor3 = Color3.new(1, 1, 1)
	text.Text = "Hello World!"
	text.TextSize = 30
	text.Font = Enum.Font.GothamBold
	
	
end)


-- BillboardGui (text that floats in 3d space )
local part = workspace:WaitForChild("Part")
local billText = part:WaitForChild("BillboardGui")
local label = billText:WaitForChild("TextLabel")





-- TextLabel 


label.BackgroundTransparency = 1
label.Text = "Floating Text!"
label.TextScaled = true
label.TextColor3 = Color3.new(0, 0, 0)
