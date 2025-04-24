local Player = require("player")
local Ball = require("ball")

function love.load()
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
		isPaused = false,
		scores = { 0, 0 },
	}

	GAME.players = {
		Player.new(15, GAME.window.h / 2),
		Player.new(GAME.window.w - 30, GAME.window.h / 2),
	}

	GAME.ball = Ball.new()

	love.window.setMode(GAME.window.w, GAME.window.h)

	local font_loaded, font = pcall(love.graphics.newFont, "block.ttf", 32)

	if font_loaded then
		love.graphics.setFont(font)
	end
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

	if GAME.ball.pos.x < GAME.bounds.left - GAME.ball.diam then
		GAME.scores[2] = GAME.scores[2] + 1
		GAME.ball = Ball.new()
	end

	if GAME.ball.pos.x > GAME.bounds.right then
		GAME.scores[1] = GAME.scores[1] + 1
		GAME.ball = Ball.new()
	end
end

function love.draw()
	local font = love.graphics.getFont()

	love.graphics.print(GAME.scores[1], 25, 25)
	love.graphics.print(GAME.scores[2], GAME.window.w - font:getWidth(GAME.scores[2]) - 25, 25)

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
