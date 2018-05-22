state = {
  current: {}
  global: {
    update: {}
    draw: {}
  }
}

setmetatable state, state

state.new = => {}

state.set = (path, args) =>
  @current.unload! if @current.unload

  matches = {}

  for match in string.gmatch path, "[^;]+"
    matches[#matches + 1] = match

  path = matches[1]

  package.loaded[path] = false

  @current = require path
  @


state.load = =>
  @current\load! if @current.load
  @

state.update = (dt) =>
  @current\update dt if @current.update
  @

state.draw = =>
  @current\draw! if @current.draw

  with love.graphics
    .setColor 0, 0, 0, 0.4
    .rectangle "fill", 0, 0, 48, 48
    .setColor 0, 0, 0
    .print love.timer.getFPS!, 16, 16

  @

state.press = (key, isrepeat) =>
  @current\press key, isrepeat if @current.press
  @

state.release = (key, isrepeat) =>
  @current\release key, isrepeat if @current.release
  @

state