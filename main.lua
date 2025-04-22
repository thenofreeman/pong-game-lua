local Player = require("player")
local Window = require("window")

-- called on initial load
function love.load()
	window = Window.new(900, 600)
	player1 = Player.new(15, window.h / 2)
	player2 = Player.new(window.w - 30, window.h / 2)

	love.window.setMode(window.w, window.h)
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
	player2:update(dt)
end

-- where the rendering happens
function love.draw()
	if isPaused then
		return
	end

	player1:draw()
	player2:draw()
end

-- called when a key is pressed
function love.keypressed(key)
	if key == "q" then
		love.event.quit()
	end

	if key == "w" then
		player1:setDirection("up")
	elseif key == "s" then
		player1:setDirection("down")
	end

	if key == "up" then
		player2:setDirection("up")
	elseif key == "down" then
		player2:setDirection("down")
	end
end

-- called when a key is released
function love.keyreleased(key)
	if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
		player1:setDirection("none")
	end

	if not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
		player2:setDirection("none")
	end
end

-- called when user clicks on or off the window
function love.focus(focused)
	isPaused = not focused
end
