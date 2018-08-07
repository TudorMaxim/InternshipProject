var refresher = function(time) {
  var interval = setInterval(function() {
    var link = window.location.href;
    $.ajax({
      type: "GET",
      url: link,
      dataType: "script",
      success: function(data) {
        //console.log(data)
        if (! ($("#result").is(":empty")) ) {
          clearInterval(interval);
          $("#result").hide().fadeIn(2000);
          $("#skins").hide().fadeIn(2000);
        }
      }
    });
  }, time);
}

var buttonPressed = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice},
    success: function(data) {
      $("#result").hide().fadeIn(2000);
      $("#skins").hide().fadeIn(2000);
      refresher(2000);
    }
  });
}

$(document).ready(function() {
  $("#skins").hide().fadeIn(2000);
  $("#result").hide().fadeIn(2000);
  $("#choices").hide().fadeIn(2000);

  $("#rock-button").click(function(event) {
    document.getElementById("paper-button").disabled = true;
    document.getElementById("scissors-button").disabled = true;
    event.preventDefault();
    buttonPressed("rock");
  });

  $("#paper-button").click(function(event) {
    document.getElementById("rock-button").disabled = true;
    document.getElementById("scissors-button").disabled = true;
    event.preventDefault();
    buttonPressed("paper");
  });

  $("#scissors-button").click(function(event) {
    document.getElementById("paper-button").disabled = true;
    document.getElementById("rock-button").disabled = true;
    event.preventDefault();
    buttonPressed("scissors");
  });
});
