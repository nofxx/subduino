// Arduino <> Subduino/Node <> WWW

var sys  = require('sys'),
    http = require('http'),
    faye = require('./vendor/faye');

var bayeux = new faye.NodeAdapter({
  mount:    '/faye',
  timeout:  45
});

sys.puts("Starting server...");

// Handle non-Bayeux requests
var server = http.createServer(function(request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'});
  response.write('Nothing to see here...');
  response.end();
});

bayeux.attach(server);
server.listen(8000);


// var client = new faye.Client('http://localhost:8000/faye');
// bayeux.getClient().publish('/email/new', {
//   text:       'New email has arrived!',
//   inboxSize:  34
// });