local Player = {}
Player.__index = Player

function Player.new(x, y)
	local player = setmetatable({}, Player)

	player.pos = { x = x, y = y }
	player.dim = { w = 100, h = 15 }

	player.speed = 50

	return player
end

function Player:update(dt)
	self.pos.x = self.pos.x + self.speed * dt
end

function Player:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.w, self.dim.h)
end

return Player
