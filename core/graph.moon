graph = {
  x: 0
  y: 550

  points_a: {
    { 0, 10 }
  }

  points_b: {
    { 0, 10 }
  }

  move_x:   0
  target_x: 0

  pos: 0
}

acc = love.graphics.getWidth! / 24

graph.plot = (points, y, x) =>
  if @pos - x > 22
    @target_x += acc / 2

    table.remove points, 1

  table.insert points, { @pos - x, y }

  @pos = @pos - x + 1

graph.update = (dt) =>
  @move_x = math.lerp @move_x, @target_x, dt * 10

graph.draw_graph = (points, color) =>
  with love.graphics
    i = 1
    i = #points - acc if #points > acc

    .setColor color[1], color[2], color[3]

    for i_ = i, #points
      last_point = points[i_ - 1] or { 0, 0 }

      if last_point[1] < points[i][1]
        last_point = points[i]

      .line last_point[1] * acc, .getHeight! - last_point[2], points[i_][1] * acc, .getHeight! - points[i_][2]

graph.draw = =>
  with love.graphics
    .setColor 1, 1, 1
    .rectangle "fill", @x, @y, .getWidth!, .getHeight! - @y

    .setColor .5, .5, .5
    .rectangle "line", @x, @y, .getWidth!, .getHeight! - @y

    .setColor .96, .96, .96

    x = 0
    a = 4

    for i = @y, .getHeight!, (.getHeight! - @y) / 10
      .line 0, i, .getWidth!, i

    .push!

    .translate -@move_x, 0

    a_color = { .8, 0, 0 }
    b_color = { 0, .8, 0 }


    @draw_graph @points_a, a_color
    @draw_graph @points_b, b_color

    .pop!

    .setColor a_color
    .rectangle "fill", @x + 10, @y + 10, 15, 15

    .setColor b_color
    .rectangle "fill", @x + 10, @y + 35, 15, 15

    .setColor 0, 0, 0
    .print "Energi", @x + 35, @y + 10
    .print "Metan", @x + 35, @y + 35
    
graph