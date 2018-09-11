var updateSkinsView = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice }
  });
}

$(document).on('turbolinks:load', function() {
  $("#all-skins").click(function(event) {
    event.preventDefault();
    updateSkinsView();
  });
  $("#rock-skins").click(function(event) {
    event.preventDefault();
    updateSkinsView("rock");
  });
  $("#paper-skins").click(function(event) {
    event.preventDefault();
    updateSkinsView("paper");
  });
  $("#scissors-skins").click(function(event) {
    event.preventDefault();
    updateSkinsView("scissors");
  });
});
