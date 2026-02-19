--// SERVICES & REFERENCES
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local event = game.ReplicatedStorage:WaitForChild("CutsceneEvent")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local cutsceneSync = game.ReplicatedStorage:WaitForChild("CutsceneSync")

local playing = false

-- Blocks all movement Controls
local function disableControls()
	return Enum.ContextActionResult.Sink
end

-- CUTSCENE START

event.OnClientEvent:Connect(function()
	
	if playing then return end
	
	local character = player.Character or player.CharacterAdded:Wait()
	local head = character:WaitForChild("Head")
	if not character then return end
	
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")
	
	if not humanoid or not root or humanoid.Health <= 0 then
		return
	end
	
	playing = true
	
	
	------------------------------------------------ 
	-- FREEZE PLAYER 
	------------------------------------------------
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.UseJumpPower = true
	humanoid.AutoRotate = false
	root.Anchored = true
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	humanoid:Move(Vector3.zero)
	humanoid:ChangeState(Enum.HumanoidStateType.None)
	
	ContextActionService:BindAction("FreezePlayer", disableControls, false,
		Enum.PlayerActions.CharacterForward, 
		Enum.PlayerActions.CharacterBackward, 
		Enum.PlayerActions.CharacterLeft, 
		Enum.PlayerActions.CharacterRight, 
		Enum.PlayerActions.CharacterJump
	)
	
	------------------------------------------------ 
	-- FIRST PERSON CAMERA SETUP 
	------------------------------------------------
	camera.CameraType = Enum.CameraType.Scriptable

	------------------------------------------------
	-- START POSITION (behind player)
	------------------------------------------------

	local startPos = root.Position + Vector3.new(0, 15, 8)

	camera.CFrame = CFrame.lookAt(startPos, head.Position)

	-- tween to look at player head
	local eyePos = CFrame.lookAt(head.Position, head.Position + head.CFrame.LookVector)
	local info = TweenInfo.new(1.95, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tween = TweenService:Create(camera, info, {CFrame = eyePos})		
	tween:Play()
	tween.Completed:Wait()

	
	local visibleParts = character:GetDescendants()
	local originalTransparency = {}

	for _, item in ipairs(visibleParts) do
		if item:IsA("BasePart") or item:IsA("Decal") or item:IsA("Texture")  then
			originalTransparency[item] = item.LocalTransparencyModifier
			item.LocalTransparencyModifier = 1
		end
	end
	
	-- rotation holders
	local yaw = Instance.new("NumberValue")
	yaw.Value = 0

	local pitch = Instance.new("NumberValue")
	pitch.Value = 0
	
	local fov = Instance.new("NumberValue")
	fov.Value = 70
	
	------------------------------------------------ 
	-- CAMERA FOLLOW (runs every frame) 
	------------------------------------------------
	local renderConnection = RunService.RenderStepped:Connect(function()
		if not playing then return end

		local base = CFrame.lookAt(head.Position, head.Position + head.CFrame.LookVector)

		local rotation = 
			CFrame.Angles(0, math.rad(yaw.Value), 0) * 
			CFrame.Angles(math.rad(pitch.Value), 0, 0)

		camera.CFrame = base * rotation
	end)
	
	------------------------------------------------ 
	-- TWEEN HELPER 
	------------------------------------------------
	local function tweenRotate(valueObject, time, target)	
		local tween = TweenService:Create(
			valueObject,
			TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{	
				Value = target,

			}
		)
		tween:Play()
		return tween
	end
	
	local function fov(time, target) 
		local tween = TweenService:Create( 
			camera, 
			TweenInfo.new(time, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
			{FieldOfView = target} ) 
		tween:Play() 
		return tween 
	end
	
	
	------------------------------------------------ 
	-- CINEMATIC SEQUENCE 
	------------------------------------------------

	------------------------------------------------
	-- LOOK LEFT (0–3s)
	------------------------------------------------
	
	tweenRotate(yaw, 3, 60).Completed:Wait()
	
	------------------------------------------------
	-- LOOK RIGHT (3–6s)
	------------------------------------------------
	
	tweenRotate(yaw, 3, -60).Completed:Wait()
	
	------------------------------------------------
	-- LOOK BACK (6-9s)
	------------------------------------------------
	
	tweenRotate(yaw, 3, 0).Completed:Wait()

	
	------------------------------------------------
	-- LOOK UP (9–12s) + FOV ZOOM ← matches server sky fade
	------------------------------------------------
	
	
	
	fov(4, 30).Completed:Wait()	
	
	-- here sky should be fading in
	cutsceneSync:FireServer("SkyFade")
	
	fov(3, 110)
	tweenRotate(pitch, 4, 45).Completed:Wait()
	
	
	tweenRotate(pitch, 2, 0).Completed:Wait()
	
	------------------------------------------------
	-- RESTORE PLAYER CONTROL (SMOOTH)
	------------------------------------------------
	
	renderConnection:Disconnect()
	
	
	
	camera.CameraType = Enum.CameraType.Custom

	-- FORCE FIRST PERSON
	player.CameraMode = Enum.CameraMode.LockFirstPerson
	player.CameraMinZoomDistance = 0.5
	player.CameraMaxZoomDistance = 0.5
	
	for part, value in pairs(originalTransparency) do
		part.LocalTransparencyModifier = value
	end
	
	yaw:Destroy()
	pitch:Destroy()
	
	fov(0.5, 90)
	
	
	
	root.Anchored = false
	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	
	task.defer(function()
		if humanoid then
			humanoid.WalkSpeed = 16
			humanoid.JumpPower = 50
			humanoid.AutoRotate = true
		end
	end)
	
	ContextActionService:UnbindAction("FreezePlayer")
	
	playing = false
end)

