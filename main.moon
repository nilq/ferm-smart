require "library"

math.lerp     = (a, b, t) -> a + (b - a) * t
math.distance = (a, b)    -> math.sqrt (a.x - b.x)^2 + (a.y - b.y)^2

with love
  .keypressed = (key) ->
    state\press key if state.press

  .keyreleased = (key) ->
    state\release key if state.release
