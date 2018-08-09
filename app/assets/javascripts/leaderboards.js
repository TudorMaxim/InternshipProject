var updateLeaderboard = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice}
  });
}

$(document).on('turbolinks:load', function() {
  $("#all_time").click(function(event) {
    event.preventDefault();
    updateLeaderboard("all_time");
  });
  $("#monthly").click(function(event) {
    event.preventDefault();
    updateLeaderboard("monthly");
  });
  $("#daily").click(function(event) {
    event.preventDefault();
    updateLeaderboard("daily");
  });
});
