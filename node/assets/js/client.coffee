#= require jquery
#= require underscore
# =require backbone
#= require bootstrapManifest
# =require socket.io
# =require helpers

@a = @a || {}

$(window).ready ->
  # set up the socket.io and OSC
  socket = io.connect() 
  a.socket = socket

  socket.on "connection", (msg) ->
    console.log "connected"
    socket.emit "hello", "world"

  $('#forward').click ->
    socket.emit $(@).attr 'id'

  $('#backward').click ->
    socket.emit $(@).attr 'id'

  $('#left').click ->
    socket.emit $(@).attr 'id'

  $('#right').click ->
    socket.emit $(@).attr 'id'

