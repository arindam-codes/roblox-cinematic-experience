-- Position (X, Y, Z)

local pos = Vector3.new(10, 5, 20)
print(pos.x) -- 10
print(pos.Y) -- 5
print(pos.z) -- 20

-- Size
local size = Vector3.new(4, 2, 4)

-- Math with Vectors
local pos1 = Vector3.new(0, 0, 0)
local pos2 = Vector3.new(10, 5, 0)
local distance = (pos1 - pos2).Magnitude -- How far apart
print(distance)

-- Moving things
local part = script.Parent
part.Postion = part.Position + Vector3.new(0, 5, 0) -- Move up 5
