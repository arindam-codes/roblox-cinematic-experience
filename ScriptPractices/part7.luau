-- Method 1: RGB 0-1 (used in scripts)
local pink = Color3.new(1, 0.75, 08) -- R, G, B (each 0-1)
local red = Color3.new(1, 0, 0)
local white = Color3.new(1, 1, 1)

-- Method 2: RGB 0-255 (easier to think)
local pink = Color3.fromRGB(255, 192, 203)
local purple = Color3.fromRGB(128, 0, 128)
local gold = Color3.fromRGB(255, 215, 0)

-- Color sequences (for particles)
local colorList = {
			ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),    -- Red at start
			ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 0)),  -- Yellow at middle
			ColorSequenceKeypoint.new(1, Color3.new(1, 0, 1))	  -- Purple at end
			}
local colorSeq = ColorSequence.new(colorList)
