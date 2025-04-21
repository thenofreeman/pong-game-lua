local Window = {}
Window.__index = Window

function Window.new(w, h)
	local window = setmetatable({}, Window)

	window.w = w
	window.h = h

	return window
end

return Window
