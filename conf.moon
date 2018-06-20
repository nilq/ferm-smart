love.conf = (t) ->
  with t.window
    .width      = 1200
    .height     = 800
    .resizable  = false
    .borderless = false

    .fullscreen = false

    .title      = "ferm-smart"