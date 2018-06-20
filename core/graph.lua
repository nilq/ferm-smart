local graph = {
  x = 0,
  y = 550,
  points_a = {
    {
      0,
      10
    }
  },
  points_b = {
    {
      0,
      10
    }
  },
  move_x = 0,
  target_x = 0,
  pos = 0
}
local acc = love.graphics.getWidth() / 24
graph.plot = function(self, points, y, x)
  if self.pos - x > 22 then
    self.target_x = self.target_x + (acc / 2)
    table.remove(points, 1)
  end
  table.insert(points, {
    self.pos - x,
    y
  })
  self.pos = self.pos - x + 1
end
graph.update = function(self, dt)
  self.move_x = math.lerp(self.move_x, self.target_x, dt * 10)
end
graph.draw_graph = function(self, points, color)
  do
    local _with_0 = love.graphics
    local i = 1
    if #points > acc then
      i = #points - acc
    end
    _with_0.setColor(color[1], color[2], color[3])
    for i_ = i, #points do
      local last_point = points[i_ - 1] or {
        0,
        0
      }
      if last_point[1] < points[i][1] then
        last_point = points[i]
      end
      _with_0.line(last_point[1] * acc, _with_0.getHeight() - last_point[2], points[i_][1] * acc, _with_0.getHeight() - points[i_][2])
    end
    return _with_0
  end
end
graph.draw = function(self)
  do
    local _with_0 = love.graphics
    _with_0.setColor(1, 1, 1)
    _with_0.rectangle("fill", self.x, self.y, _with_0.getWidth(), _with_0.getHeight() - self.y)
    _with_0.setColor(.5, .5, .5)
    _with_0.rectangle("line", self.x, self.y, _with_0.getWidth(), _with_0.getHeight() - self.y)
    _with_0.setColor(.96, .96, .96)
    local x = 0
    local a = 4
    for i = self.y, _with_0.getHeight(), (_with_0.getHeight() - self.y) / 10 do
      _with_0.line(0, i, _with_0.getWidth(), i)
    end
    _with_0.push()
    _with_0.translate(-self.move_x, 0)
    local a_color = {
      .8,
      0,
      0
    }
    local b_color = {
      0,
      .8,
      0
    }
    self:draw_graph(self.points_a, a_color)
    self:draw_graph(self.points_b, b_color)
    _with_0.pop()
    _with_0.setColor(a_color)
    _with_0.rectangle("fill", self.x + 10, self.y + 10, 15, 15)
    _with_0.setColor(b_color)
    _with_0.rectangle("fill", self.x + 10, self.y + 35, 15, 15)
    _with_0.setColor(0, 0, 0)
    _with_0.print("Energi", self.x + 35, self.y + 10)
    _with_0.print("Metan", self.x + 35, self.y + 35)
    return _with_0
  end
end
return graph
