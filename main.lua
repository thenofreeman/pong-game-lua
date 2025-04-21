-- called on initial load
function love.load()
	-- ...
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
end

-- where the rendering happens
function love.draw()
	love.graphics.print("Hello, World!", 400, 300)
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
	-- ...
end

-- called when a key is released
function love.keyreleased(key)
	-- ...
end

-- called when user clicks on or off the window
function love.focus(focused)
	isPaused = not focused
end
