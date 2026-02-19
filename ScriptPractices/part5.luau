-- Simple function
function sayHello()
	print("Hello!")
end

sayHello()

-- Function with params
function greet(name)
	print("hello " .. name .. " <3")
end

greet("Sarah")

-- Functions that returns value
function addNumbers(a, b)
	local result = a + b
	return result
end

local sum = addNumbers(5, 3)
print(sum)

-- Function stored in variable (like python lambda)
local multiply = function(a, b)
	return a * b
end

print(multiply(4, 5))
