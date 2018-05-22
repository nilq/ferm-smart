require("library")
math.lerp = function(a, b, t)
  return a + (b - a) * t
end
math.distance = function(a, b)
  return math.sqrt((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2)
end
do
  local _with_0 = love
  _with_0.keypressed = function(key)
    if state.press then
      return state:press(key)
    end
  end
  _with_0.keyreleased = function(key)
    if state.release then
      return state:release(key)
    end
  end
  return _with_0
end
