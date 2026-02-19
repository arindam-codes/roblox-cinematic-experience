--[[task.wait(3)
local camera = workspace.CurrentCamera
local focus = game:GetService("RunService")

camera.CameraType = Enum.CameraType.Scriptable

local part = workspace:WaitForChild("StartPart")


focus.RenderStepped:Connect(function()
	camera.CFrame = CFrame.new(Vector3.new(0, 10, 10) + part.Position, part.Position - part.CFrame.LookVector * 10)

end)]]

--[[task.wait(3)

local startPart = workspace:WaitForChild("StartPart")
local endPart = workspace:WaitForChild("EndPart")
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
local TweenService = game:GetService("TweenService")
local focus = game:GetService("RunService")


local startCF = CFrame.lookAt(startPart.Position + Vector3.new(0, 5, - 5), startPart.Position +  - endPart.CFrame.LookVector * 10)
local endCF = CFrame.lookAt(endPart.Position + Vector3.new(0, 7, 7), endPart.Position + endPart.CFrame.LookVector * 10)

local info = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local tweenLook = TweenService:Create(camera, info, {CFrame = startCF})
tweenLook:Play()
tweenLook.Completed:Wait()

local info = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local tweenMove = TweenService:Create(camera, info, {CFrame = endCF})
tweenMove:Play()
tweenMove.Completed:Wait()
]]

task.wait(3)
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local head = character:WaitForChild("Head")

camera.CFrame = CFrame.lookAt(head.Position, head.Position + head.CFrame.LookVector)

local visibleParts = character:GetDescendants()
local originalTransparency = {}

for _, item in ipairs(visibleParts) do
	if item:IsA("BasePart") then
		originalTransparency[item] = item.LocalTransparencyModifier
		item.LocalTransparencyModifier = 1
	end
end


local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local yaw = Instance.new("NumberValue")
yaw.Value = 0

local pitch = Instance.new("NumberValue")
pitch.Value = 0

local playing = true

RunService.RenderStepped:Connect(function()
	if not playing then return end
	
	local base = CFrame.lookAt(head.Position, head.Position + head.CFrame.LookVector)
	
	local rotation = 
		CFrame.Angles(0, math.rad(yaw.Value), 0) * 
		CFrame.Angles(math.rad(pitch.Value), 0, 0)
	
	camera.CFrame = base * rotation
end)

function tweenRotate(valueObject, time, target, value)	
	local tween = TweenService:Create(
		valueObject,
		TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
		{	
			Value = target,
			FieldOfView = value
			
		}
	)
	tween:Play()
	return tween
end

tweenRotate(yaw, 3, 60, 70).Completed:Wait()

tweenRotate(yaw, 3, -60, 70).Completed:Wait()

tweenRotate(yaw, 3, 0, 70).Completed:Wait()

tweenRotate(pitch, 4, 35, 50).Completed:Wait()


task.wait(1)

for part, value in pairs(originalTransparency) do
	part.LocalTransparencyModifier = value
end

playing = false





