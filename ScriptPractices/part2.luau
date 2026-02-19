-- like python list
local colors = {"red", "pink", "purple"}
print(colors[1])

-- like python dictionary
local girlfriend = {
	name = "Sarah",
	age = "20",
	isAmazing = true
}

print(girlfriend["name"])
print(girlfriend.age)

-- Mixed table
local memories = {
	{date = "Feb 1", text = "First meeting"},
	{date = "Feb 14", text = "First date"}
}
print(memories[2].text)
