make = (x, y) ->
  methanogen = {
    :x, :y

    dx: 0, dy: 0

    clock: 0
    angle: 0

    radius: 10

    speed: 18

    color: { 0, 200 / 255, 100 / 255 }

    cluster: {}
  }

  methanogen.update = (dt) =>
    @clock += dt

    if @clock % 150
      @angle = math.lerp @angle, (@angle + math.random -60, 60), dt * .5

    @x += @speed * dt * math.cos @angle
    @y += @speed * dt * math.sin @angle

    with love.graphics
      @x %= .getWidth!
      @y %= 550
    
    @chain dt

  methanogen.chain = (dt) =>
    for i = 0, #core.cells
      other = core.cells[i]

      unless other == @
        a = math.distance @, other

        if a < 2 * (@radius + other.radius)
          @cluster[i] = true

          sum = @cluster_sum!

          @move_towards { x: (sum.x ), y: sum.y}
        else
          @cluster[i] = false

  methanogen.move_towards = (other) =>
    a   = math.atan2 @y - other.y, @x - other.x

    @dx *= math.cos a
    @dy *= math.sin a
  
  methanogen.cluster_sum = =>
    x, y = 0, 0
    
    for i, thing in ipairs @cluster
      if thing
        a = core.cells[i]

        x += a.x
        y += a.y

    { x: x / #@cluster, y: y / #@cluster }

  methanogen.draw = =>
    with love.graphics
      .setColor @color
      .circle "fill", @x, @y, @radius

      .setColor 0, 200 / 255, 100 / 255
      .circle "line", @x, @y, @radius

      .setColor 0, 0, 0
      .circle "fill", @x, @y, 2

  methanogen

{
  :make
}