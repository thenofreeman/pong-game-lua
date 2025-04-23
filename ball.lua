local Ball = {}
Ball.__index = Ball

function Ball.new(x, y)
	local ball = setmetatable({}, Ball)

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
	if self.pos.y <= GAME.bounds.top or self.pos.y + self.diam >= GAME.bounds.bottom then
		self.velocity.y = self.velocity.y * -1
	end

	self.pos.x = self.pos.x + self.speed * dt * self.velocity.x
	self.pos.y = self.pos.y + self.speed * dt * self.velocity.y
end

function Ball:draw()
	love.graphics.circle("fill", self.pos.x, self.pos.y, self.diam)
end

return Ball
