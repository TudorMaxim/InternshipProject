var buttonPressed = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice},
    success: function(data) {
      $("#table_content").hide().fadeIn(1000);
    }
  });
}

$(document).on('turbolinks:load', function() {
  $("#all_time").click(function(event) {
    event.preventDefault();
    buttonPressed("all_time");
  });
  $("#monthly").click(function(event) {
    event.preventDefault();
    buttonPressed("monthly");
  });
  $("#daily").click(function(event) {
    event.preventDefault();
    buttonPressed("daily");
  });
});
