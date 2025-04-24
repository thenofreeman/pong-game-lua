local Player = {}
Player.__index = Player

function Player.new(x, y)
	local player = setmetatable({}, Player)

	player.pos = { x = x, y = y }
	player.dim = { w = 15, h = 100 }

	player.edge = {
		left = player.pos.x,
		right = player.pos.x + player.dim.w,
		top = player.pos.y,
		bottom = player.pos.y + player.dim.h,
	}

	player.speed = 400
	player.dir = "none"

	return player
end

function Player:update(dt)
	if self.dir == "up" then
		self.pos.y = self.pos.y - self.speed * dt
	end

	if self.dir == "down" then
		self.pos.y = self.pos.y + self.speed * dt
	end

	self.edge.top = self.pos.y
	self.edge.bottom = self.pos.y + self.dim.h

	if self.edge.top < GAME.bounds.top then
		self.pos.y = GAME.bounds.top
	end

	if self.edge.bottom > GAME.bounds.bottom then
		self.pos.y = GAME.bounds.bottom - self.dim.h
	end
end

function Player:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.w, self.dim.h)
end

function Player:setDirection(dir)
	self.dir = dir
end

return Player
