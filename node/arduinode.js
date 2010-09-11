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


var spawn = require('child_process').spawn,
    stty  = spawn('stty -F /dev/ttyUSB1 cs8 115200 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts'); //, ['-lh', '/usr']);

stty.stdout.on('data', function (data) {
  sys.print('stdout: ' + data);
});

stty.stderr.on('data', function (data) {
  log("Could not stty " + dpath);
  log('stderr: ' + data);
});

stty.on('exit', function (code) {
  if (code == 0)
    console.log('Done modding stty ' + dpath);
});


// stty -F /dev/ttyUSB1 cs8 115200 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts
var rr = fs.createReadStream(dpath, {
  'flags': 'r',
  'encoding': 'ascii', // binary, utf8
  // 'mode': 0666,
  // 'bufferSize': 4 * 1024
});


rr.addListener('data', function (chunk) {
  log('data: ' + chunk);
  log(sys.inspect(chunk));
});

rr.on('end', function () {
  log('end, closed fs');
});



