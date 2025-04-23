local Player = {}
Player.__index = Player

function Player.new(x, y)
	local player = setmetatable({}, Player)

	player.pos = { x = x, y = y }
	player.dim = { w = 15, h = 100 }

	player.speed = 200
	player.dir = "none"

	return player
end

function Player:update(dt)
	local player_top_edge = self.pos.y
	local player_bottom_edge = self.pos.y + self.dim.h

	if self.dir == "up" then
		if player_top_edge > GAME.bounds.top then
			self.pos.y = self.pos.y - self.speed * dt
		end
	end

	if self.dir == "down" then
		if player_bottom_edge < GAME.bounds.bottom then
			self.pos.y = self.pos.y + self.speed * dt
		end
	end
end

function Player:draw()
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.w, self.dim.h)
end

function Player:setDirection(dir)
	self.dir = dir
end

return Player
