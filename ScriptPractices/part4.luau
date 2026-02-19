-- FOR loop(count 1 to 10)

for i = 1, 10 do 
	print("Number: " .. i)
end

-- FOR loop with step
for i = 1, 10, 2 do
	print("Odd numbers: " .. i)
end

-- WHILE loop
local count = 0
while count < 5 do
	print("Count: " .. count)
	count += 1
	wait(1)
end

-- FOREACH (dictionary)
local info = {name = "Sarah", age = 20}
for key, value in pairs(info) do
	print(key .. " = " .. value)
end 

-- FOREACH (looping thru table)
local colors = {"red", "pink", "purple"}
for index, color in ipairs(colors) do
	print(index .. " : " .. color)
end
