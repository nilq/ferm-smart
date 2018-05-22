local make
make = function(x, y)
  local methanogen = {
    x = x,
    y = y,
    dx = 0,
    dy = 0,
    clock = 0,
    angle = 0,
    radius = 10,
    speed = 18,
    color = {
      0,
      200 / 255,
      100 / 255
    },
    cluster = { }
  }
  methanogen.update = function(self, dt)
    self.clock = self.clock + dt
    if self.clock % 150 then
      self.angle = math.lerp(self.angle, (self.angle + math.random(-60, 60)), dt * .5)
    end
    self.x = self.x + (self.speed * dt * math.cos(self.angle))
    self.y = self.y + (self.speed * dt * math.sin(self.angle))
    do
      local _with_0 = love.graphics
      self.x = self.x % _with_0.getWidth()
      self.y = self.y % _with_0.getHeight()
    end
    return self:chain(dt)
  end
  methanogen.chain = function(self, dt)
    for i = 0, #core.cells do
      local other = core.cells[i]
      if not (other == self) then
        local a = math.distance(self, other)
        if a < 2 * (self.radius + other.radius) then
          self.cluster[i] = true
          local sum = self:cluster_sum()
          self:move_towards({
            x = (sum.x),
            y = sum.y
          })
        else
          self.cluster[i] = false
        end
      end
    end
  end
  methanogen.move_towards = function(self, other)
    local a = math.atan2(self.y - other.y, self.x - other.x)
    self.dx = self.dx * math.cos(a)
    self.dy = self.dy * math.sin(a)
  end
  methanogen.cluster_sum = function(self)
    x, y = 0, 0
    for i, thing in ipairs(self.cluster) do
      if thing then
        local a = core.cells[i]
        x = x + a:cluster_sum().x
        y = y + a:cluster_sum().y
      end
    end
    return {
      x = x / #self.cluster,
      y = y / #self.cluster
    }
  end
  methanogen.draw = function(self)
    do
      local _with_0 = love.graphics
      _with_0.setColor(self.color)
      _with_0.circle("fill", self.x, self.y, self.radius)
      _with_0.setColor(0, 200 / 255, 100 / 255)
      _with_0.circle("line", self.x, self.y, self.radius)
      _with_0.setColor(0, 0, 0)
      _with_0.circle("fill", self.x, self.y, 2)
      return _with_0
    end
  end
  return methanogen
end
return {
  make = make
}
