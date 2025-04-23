local Player = require("player")
local Ball = require("ball")

GAME = {
	window = {
		w = 900,
		h = 600,
	},
	bounds = {
		left = 0,
		right = 900,
		top = 0,
		bottom = 600,
	},
	players = {
		Player.new(15, 600 / 2),
		Player.new(900 - 30, 600 / 2),
	},
	ball = Ball.new(450, 300),
	isPaused = false,
}

-- called on initial load
function love.load()
	love.window.setMode(GAME.window.w, GAME.window.h)
end

-- called on window close
function love.quit()
	-- ...
end

-- update game logic
-- dt = delta time; time in seconds since last call
function love.update(dt)
	if GAME.isPaused then
		return
	end

	-- for player in GAME.players do
	-- 	player:update(dt)
	-- end

	GAME.players[1]:update(dt)
	GAME.players[2]:update(dt)
	GAME.ball:update(dt)
end

-- where the rendering happens
function love.draw()
	if GAME.isPaused then
		return
	end

	GAME.players[1]:draw()
	GAME.players[2]:draw()
	GAME.ball:draw()
end

-- called when a key is pressed
function love.keypressed(key)
	if key == "q" then
		love.event.quit()
	end

	if key == "w" then
		GAME.players[1]:setDirection("up")
	elseif key == "s" then
		GAME.players[1]:setDirection("down")
	end

	if key == "up" then
		GAME.players[2]:setDirection("up")
	elseif key == "down" then
		GAME.players[2]:setDirection("down")
	end
end

-- called when a key is released
function love.keyreleased()
	if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
		GAME.players[1]:setDirection("none")
	end

	if not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
		GAME.players[2]:setDirection("none")
	end
end

-- called when user clicks on or off the window
function love.focus(focused)
	GAME.isPaused = not focused
end
