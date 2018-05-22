core = { }
local methanogen
methanogen = require("core/bacteria").methanogen
core.load = function(self)
  math.randomseed(os.time())
  self.cells = { }
  for i = 0, 450 do
    do
      local _with_0 = love.graphics
      self.cells[i] = methanogen.make((math.random(0, _with_0.getWidth())), math.random(0, _with_0.getHeight()))
    end
  end
end
core.update = function(self, dt)
  for i = 0, #self.cells do
    self.cells[i]:update(dt)
  end
end
core.draw = function(self)
  for i = 0, #self.cells do
    self.cells[i]:draw()
  end
end
return core
