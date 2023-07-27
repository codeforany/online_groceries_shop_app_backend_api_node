var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const cors = require('cors');
var fs = require('fs');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();
var server = require('http').createServer(app);
var io = require('socket.io')(server, {
  cors: {
    origin: "http://localhost:4200",
    methods: ["GET", "POST"]
  }
})
var serverPort = 3001;

var user_socket_connect_list = [];

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json({ limit: '100mb' }));
app.use(express.urlencoded({ extended: true, limit: '100mb' }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

const corsOptions = {
  origin: "http://localhost:4200",
}

app.use(cors(corsOptions));

// import express inside dynamic added.
fs.readdirSync('./controllers').forEach((file) => {
  if (file.substr(-3) == ".js") {
    route = require('./controllers/' + file);
    route.controller(app, io, user_socket_connect_list);
  }
})

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

server.listen(serverPort);

console.log("Server Start : " + serverPort );

Array.prototype.swap = (x, y) => {
  var b = this[x];
  this[x] = this[y];
  this[y] = b;
  return this;
}

Array.prototype.insert = (index, item) => {
  this.splice(index, 0, item);
}

Array.prototype.replace_null = (replace = '""') => {
  return JSON.parse(JSON.stringify(this).replace(/null/g, replace));
}

String.prototype.replaceAll = (search, replacement) => {
  var target = this;
  return target.replace(new RegExp(search, 'g'), replacement);
}
