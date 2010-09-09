
 var client = new Faye.Client('http://192.168.0.15:8000/faye');

var subscription = client.subscribe('/stats', function(message) {
//  console.log(message);
  $('#stats').append("<div>" + message["data"] + "</div>");
});