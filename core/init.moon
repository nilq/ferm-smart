export core = {
  methane: 4 -- 1 in 
  energy:  100

  glucose: 50

  timer: 2
}

import methanogen from require "core/bacteria"

graph = require "core/graph"
love.graphics.setBackgroundColor .95, 1, .95

core.load = =>
  print "hey"
  math.randomseed os.time!

  @cells = {}
  @atoms = {}

  for i = 0, 450
    with love.graphics
      @cells[i] = methanogen.make (math.random 0, .getWidth!), math.random 0, .getHeight!


core.update = (dt) =>
  if love.keyboard.isDown "down"
    @glucose -= 0.5
  
  if love.keyboard.isDown "up"
    @glucose += 0.5

  @energy  = @glucose - @methane * 0.5
  @methane = @glucose / 2

  @timer -= dt * 5

  if @timer <= 0
    graph\plot graph.points_a, 10 + @energy  + (math.random -10, 10) / 10, 0
    graph\plot graph.points_b, 10 + @methane + (math.random -10, 10) / 10, 1

    @timer = 2

  graph\update dt
    
  for i = 0, #@cells
    @cells[i]\update dt

core.draw = =>
  for i = 0, #@cells
    @cells[i]\draw!

  graph\draw!

core