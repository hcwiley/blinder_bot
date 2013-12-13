###
Module dependencies.
###
config = require("./config")
express = require("express")
lessMiddleware = require('less-middleware')
path = require("path")
http = require("http")
socketIo = require("socket.io")
path = require('path')
pubDir = path.join(__dirname, 'public')
child = require('child_process')
SerialPort = require("serialport").SerialPort
serialPort = new SerialPort process.env.SERIAL_PORT,
  baudrate: 9600
, false
serialError = false

# create app, server, and web sockets
app = express()
server = http.createServer(app)
io = socketIo.listen(server)

# Make socket.io a little quieter
io.set "log level", 1

app.configure ->
  bootstrapPath = path.join(__dirname, 'assets','css', 'bootstrap')
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  
  # use the connect assets middleware for Snockets sugar
  app.use require("connect-assets")()
  app.use express.favicon()
  app.use express.logger(config.loggerFormat)
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser(config.sessionSecret)
  app.use express.session(secret: "shhhh")
  app.use app.router
  app.use lessMiddleware
        src: path.join(__dirname,'assets','css')
        paths  : bootstrapPath
        dest: path.join(__dirname,'public','css')
        prefix: '/css'
        compress: true
  app.use express.static(pubDir)
  app.use express.errorHandler()  if config.useErrorHandler

io.sockets.on "connection",  (socket) ->

  socket?.emit "connection", "I am your father"

  socket.on "disconnect", ->
    console.log "disconnected"

  socket.on "forward", (data) ->
    serialPort.write "w", (err, results) ->
      if err
        console.log('err ' + err)
        openSerial()
      console.log('results ' + results)

  socket.on "backward", (data) ->
    serialPort.write "s", (err, results) ->
      if err
        console.log('err ' + err)
        openSerial()
      console.log('results ' + results)

  socket.on "left", (data) ->
    serialPort.write "a", (err, results) ->
      if err
        console.log('err ' + err)
        openSerial()
      console.log('results ' + results)

  socket.on "right", (data) ->
    serialPort.write "d", (err, results) ->
      if err
        console.log('err ' + err)
        openSerial()
      console.log('results ' + results)


# UI routes
app.get "/", (req, res) ->
  res.render "index.jade"

openSerial = ->
  prev = process.env.SERIAL_PORT
  if serialError
    if prev = '/dev/ttyACM0'
      process.env.SERIAL_PORT= '/dev/ttyACM1'
    else
      process.env.SERIAL_PORT= '/dev/ttyACM0'
  port = process.env.SERIAL_PORT
  serialPort = new SerialPort port,
      baudrate: 9600
  , true

openSerial()

serialPort.on 'data', (data) ->
  console.log('data received: ' + data)

serialPort.on 'error', (err) ->
  serialError = true
  openSerial()

fs = require 'fs'
captureImage = ->
  child.execFile "./captureImage.sh", (err, stdout, stderr) ->
    fs.readFile './public/img/foobar.jpeg', (err, data)->
      io.sockets.emit "imageUpdate", data.toString('base64')
    captureImage()

captureImage()

server.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

