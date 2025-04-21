local Player = require("player")
local Window = require("window")

-- called on initial load
function love.load()
	window = Window.new(900, 600)
	player1 = Player.new(0, window.h / 2)
end

-- called on window close
function love.quit()
	-- ...
end

-- update game logic
-- dt = delta time; time in seconds since last call
function love.update(dt)
	if isPaused then
		return
	end

	player1:update(dt)
end

-- where the rendering happens
function love.draw()
	player1:draw()
end

-- called when mouse button is pressed
function love.mousepressed(x, y, button, istouch)
	-- ...
end

-- called when mouse button is released
function love.mousereleased(x, y, button, istouch)
	-- ...
end

-- called when a key is pressed
function love.keypressed(key)
	if key == "q" then
		love.event.quit()
	end

	if key == "w" then
		player1:setDirection("up")
	end

	if key == "s" then
		player1:setDirection("down")
	end
end

-- called when a key is released
function love.keyreleased(key)
	player1:setDirection("none")
end

-- called when user clicks on or off the window
function love.focus(focused)
	isPaused = not focused
end
