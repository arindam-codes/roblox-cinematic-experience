local age = 18

if age >= 18 then
	print("You can enter")
elseif age == 17 then
	print("Almost there!")
else 
	print("Too young")
end

-- AND/OR
if age < 13 or age > 100 then
	print("Age out of range")
end

-- NOT
local isGameFinished = false
if not isGameFinished then
	print("Game still going")
end
