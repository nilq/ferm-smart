core = {
  methane = 4,
  energy = 100,
  glucose = 50,
  timer = 2
}
local methanogen
methanogen = require("core/bacteria").methanogen
local graph = require("core/graph")
love.graphics.setBackgroundColor(.95, 1, .95)
core.load = function(self)
  print("hey")
  math.randomseed(os.time())
  self.cells = { }
  self.atoms = { }
  for i = 0, 450 do
    do
      local _with_0 = love.graphics
      self.cells[i] = methanogen.make((math.random(0, _with_0.getWidth())), math.random(0, _with_0.getHeight()))
    end
  end
end
core.update = function(self, dt)
  if love.keyboard.isDown("down") then
    self.glucose = self.glucose - 0.5
  end
  if love.keyboard.isDown("up") then
    self.glucose = self.glucose + 0.5
  end
  self.energy = self.glucose - self.methane * 0.5
  self.methane = self.glucose / 2
  self.timer = self.timer - (dt * 5)
  if self.timer <= 0 then
    graph:plot(graph.points_a, 10 + self.energy + (math.random(-10, 10)) / 10, 0)
    graph:plot(graph.points_b, 10 + self.methane + (math.random(-10, 10)) / 10, 1)
    self.timer = 2
  end
  graph:update(dt)
  for i = 0, #self.cells do
    self.cells[i]:update(dt)
  end
end
core.draw = function(self)
  for i = 0, #self.cells do
    self.cells[i]:draw()
  end
  return graph:draw()
end
return core
