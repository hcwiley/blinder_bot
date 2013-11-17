#= require jquery
#= require socket.io

@a = @a || {}

$(window).ready ->
  # set up the socket.io and OSC
  socket = io.connect() 
  a.socket = socket

  socket.on "connection", (msg) ->
    console.log "connected"
    socket.emit "hello", "world"

  socket.on "imageUpdate", (msg) ->
    $("#live").attr 'src', "data:image/jped;base64,#{msg}"

  emitter = false
  id = ''
  $('button').on('mousedown touchstart', ->
    if emitter
      window.clearInterval emitter
    id = $(@).attr 'id'
    emitter = window.setInterval ->
      socket.emit id
    , 10
    return false
  ).on 'mouseup touchend', ->
    if emitter
      window.clearInterval emitter
    return false
