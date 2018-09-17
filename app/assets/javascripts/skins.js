var updateSkinsView = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice,
            page: 1 }
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

  $("#add_skin_button").click(function() {
    $("#skin_name").val('');
    $("#skin_skin_type").val('');
    $("#skin_price").val('');
    $("#skin_image").val('');
  });
  $("[data-behavior='close_add_skin_modal']").click(function() {
    $("#skin_error_explanation").html("");
  });

});
