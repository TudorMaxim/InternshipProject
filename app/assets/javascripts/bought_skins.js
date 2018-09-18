var updateInventoryView = function(myChoice) {
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
  $("#all-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView();
  });
  $("#rock-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("rock");
  });
  $("#paper-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("paper");
  });
  $("#scissors-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("scissors");
  });
  $("#selected-bought-skins").click(function(event) {
    updateInventoryView("selected")
  });

  $("[data-behavior='checkbox']").click(function(event) {
    alert("clicked");
  });
});
