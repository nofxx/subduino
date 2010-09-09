
 var client = new Faye.Client('http://localhost:8000/faye');

var subscription = client.subscribe('/stats', function(message) {
//  console.log(message);
  $('#stats').append("<div>" + message["data"] + "</div>");
});