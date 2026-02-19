task.wait(10)
local camera = workspace.CurrentCamera
local startPart = workspace:WaitForChild(("StartPart"))
local endPart = workspace:WaitForChild(("EndPart"))
local TweenService = game:GetService("TweenService")

--[[
if not camera then
	camera = workspace:GetPropertyChangedSignal("CurrentCamera"):Wait()
end

local player = game.Players.LocalPlayer
if not player.Character then player.CharacterAdded:Wait() end

repeat
	camera.CameraType = Enum.CameraType.Scriptable
	task.wait()
until camera.CameraType == Enum.CameraType.Scriptable
]]


-- move(startPart, Vector3.new(0, 20, 0), 2)

-- rotating things using Orientation
function rotate(part, where, time)
	local info = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tweenRotate = TweenService:Create(part, info, {Orientation = part.Orientation + where})
	tweenRotate:Play()
	tweenRotate.Completed:Wait()
end
-- rotate(startPart, Vector3.new(0, 180, 0), 2)

function move(part, where, time)

	local info = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tweenMove = TweenService:Create(part, info, {Position = part.Position + where})
	tweenMove:Play()
	return tweenMove
end

-- rotating things using CFrame
function cRotate(part, rotationVector, time)
	local info = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local goal = {}
	goal.CFrame = part.CFrame * CFrame.Angles(
		math.rad(rotationVector.X),
		math.rad(rotationVector.Y),
		math.rad(rotationVector.Z)
	)
	
	local tweenRotate = TweenService:Create(part, info, goal)
	tweenRotate:Play()
	return tweenRotate
end

-- cRotate(startPart, Vector3.new(0, 180, 0), 2)
function fade(part, time)
	local info = TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tweenFade = TweenService:Create(part, info, {Transparency = 1})
	tweenFade:Play()
	return tweenFade
end


local t1 = move(startPart, Vector3.new(0, 20, 2), 2)
local t2 = cRotate(startPart, Vector3.new(0, 180, 0), 2)
local t3 = fade(startPart, 2)

t1.Completed:Wait()
t2.Completed:Wait()
t3.Completed:Wait()


