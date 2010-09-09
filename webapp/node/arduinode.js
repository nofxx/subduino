// Arduino Node.js


var sys  = require('sys'),
fs  = require('fs'),
faye  = require('./vendor/faye');

var dpath = "/dev/ttyUSB1";

var client = new faye.Client('http://localhost:8000/faye');

var subscription = client.subscribe('/foo', function(message) {
  sys.puts("SUB!!!");  // handle message
});

var log = function(txt) {
  sys.puts(txt)
}

var find_arduino = function(err, stats) {
  if(err)
    return log("Arduino not found...");

  log("DUIN!");
  log(sys.inspect(stats));
}

fs.stat("/dev/ttyUSB1", find_arduino);


var rr = fs.createReadStream(dpath);


rr.addListener('data', function (chunk) {
  log('data: ' + chunk);
});

rr.on('data', function (chunk) {
  log('data: ' + chunk);
});

rr.on('end', function () {
  log('end');
});






