//FIXME: grr... bug if you run once, cancel, and try to run on another watch (hate js..)
function submitCommand(action, watch) {
  var comm;
  var act;
  var s;

  if (document.getElementById("toggle_" + action)) {
    act = document.getElementById("toggle_" + action);
    s = act.getAttribute("toggled");

    if(action == "power") {
      comm =  (s == "true") ? "start" : "stop";
    } else {
      comm =  (s == "true") ? "monitor" : "unmonitor";
    }
  } else {
    comm = action;
  }

  if (confirm("God will " + comm + " " + watch + "..")) {
    var res =  document.getElementById("command_result");
    iui.showPageByHref("/w/" + watch + "/" + comm, null, null, res, null);
  } else {
    act.setAttribute("toggled",  (s == "true") ? "false" : "true");
  }
  return false;
}

