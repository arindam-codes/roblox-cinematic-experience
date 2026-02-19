-- Create a new part
local myPart = Instance.new("Part")

-- Set its properties
myPart.Name = "Mypart"
myPart.Size = Vector3.new(4, 1, 4)
myPart.Position = Vector3.new(0, 10, 0)
myPart.Color = Color3.new(1, 0, 0)
-- OR
myPart.Color = Color3.fromRGB(255, 0, 0)

myPart.Anchored = true -- Won't fall
myPart.CanCollide = true -- Can walk on it
myPart.Transparency = 0.5 -- 0 = solid, 1 = invisible

-- Put it in the game
myPart.Parent = workspace

-- Other useful Instance types
local sphere = Instance.new("Part")
sphere.Shape = Enum.PartType.Ball -- Makes it round
sphere.Position = Vector3.new(5, 10, 0)
sphere.Parent = workspace

local wedge = Instance.new("WedgePart")
wedge.Position = Vector3.new(-5, 10, 0)
wedge.Parent = workspace

local cylinder = Instance.new("Part")
cylinder.Shape = Enum.PartType.Cylinder
cylinder.Position = Vector3.new(10, 10, 0)
cylinder.Parent = workspace

local light = Instance.new("PointLight") -- Light Source
light.Brightness = 10
light.Range = 10
light.Color = Color3.new(1, 1, 0) -- Yellow
light.Parent = myPart
