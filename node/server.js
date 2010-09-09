// Arduino <> Subduino/Node <> WWW

var sys  = require('sys'),
    http = require('http'),
    faye = require('./vendor/faye');

var bayeux = new faye.NodeAdapter({
  mount:    '/faye',
  timeout:  45
});

sys.puts("Starting server...");

// process.on('SIGHUP', function () {
//   sys.puts('Got SIGHUP signal.');
// });
// process.on('SIGKILL', function () {
//   sys.puts('Got SIGHUP signal.');
// });

// Handle non-Bayeux requests
var server = http.createServer(function(request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'});
  response.write('Nothing to see here...');
  response.end();
});

server.on('stream', function(stream) {
  sys.puts("Stream!");
  sys.puts(stream);
})

var listen_callback = function() {
  sys.log("Server started...");
}

bayeux.attach(server);
server.listen(8000, listen_callback);


// var client = new faye.Client('http://localhost:8000/faye');
// bayeux.getClient().publish('/email/new', {
//   text:       'New email has arrived!',
//   inboxSize:  34
// });