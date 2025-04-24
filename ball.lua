local Ball = {}
Ball.__index = Ball

function Ball.new()
	local ball = setmetatable({}, Ball)

	local x = love.math.random(GAME.window.w / 3) + GAME.window.w / 3
	local y = love.math.random(GAME.window.h / 2) + GAME.window.h / 4

	ball.pos = { x = x, y = y }
	ball.diam = 10

	ball.speed = 200
	ball.velocity = {
		x = 1,
		y = 1,
	}
	ball.dir = "none"

	return ball
end

function Ball:update(dt)
	self.pos.x = self.pos.x + self.speed * dt * self.velocity.x
	self.pos.y = self.pos.y + self.speed * dt * self.velocity.y

	if self.pos.y < GAME.bounds.top then
		self.pos.y = GAME.bounds.top
		self.velocity.y = self.velocity.y * -1
	elseif self.pos.y + self.diam > GAME.bounds.bottom then
		self.pos.y = GAME.bounds.bottom - self.diam
		self.velocity.y = self.velocity.y * -1
	end
end

function Ball:draw()
	love.graphics.circle("fill", self.pos.x, self.pos.y, self.diam)
end

return Ball
