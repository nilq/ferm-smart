love.conf = (t) ->
  with t.window
    .width      = 1200
    .height     = 600
    .resizable  = false
    .borderless = false

    .fullscreen = false

    .title      = "ferm-smart"