export core = {}

import methanogen from require "core/bacteria"

core.load = =>
  math.randomseed os.time!

  @cells = {}

  for i = 0, 450
    with love.graphics
      @cells[i] = methanogen.make (math.random 0, .getWidth!), math.random 0, .getHeight!

core.update = (dt) =>
  for i = 0, #@cells
    @cells[i]\update dt

core.draw = =>
  for i = 0, #@cells
    @cells[i]\draw!

core