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

function love.load()
	love.window.setMode(GAME.window.w, GAME.window.h)
end

function love.quit()
	-- ...
end

function love.update(dt)
	if GAME.isPaused then
		return
	end

	GAME.players[1]:update(dt)
	GAME.players[2]:update(dt)
	GAME.ball:update(dt)

	for _, player in pairs(GAME.players) do
		local xIntersects = GAME.ball.pos.x + GAME.ball.diam > player.edge.left and GAME.ball.pos.x < player.edge.right
		local yIntersects = GAME.ball.pos.y + GAME.ball.diam > player.edge.top and GAME.ball.pos.y < player.edge.bottom

		if xIntersects and yIntersects then
			GAME.ball.velocity.x = GAME.ball.velocity.x * -1

			if GAME.ball.velocity.x > 0 then
				GAME.ball.pos.x = player.edge.right
			else
				GAME.ball.pos.x = player.edge.left - GAME.ball.diam
			end
		end
	end
end

function love.draw()
	if GAME.isPaused then
		return
	end

	GAME.players[1]:draw()
	GAME.players[2]:draw()
	GAME.ball:draw()
end

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

function love.keyreleased()
	if not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
		GAME.players[1]:setDirection("none")
	end

	if not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
		GAME.players[2]:setDirection("none")
	end
end

function love.focus(focused)
	GAME.isPaused = not focused
end
