var updateSelectedSkins = function(skin_id, checked, choice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: choice,
            skin_id: skin_id,
            checked: checked
          },
    success: function(data) {
      checkboxClicked(choice);
    }
  });
}

var checkboxClicked = function(choice) {
  $("[data-behavior='checkbox']").click(function(event) {
    var skin_id = $(this).data("skin-id");
    updateSelectedSkins(skin_id, this.checked, choice);
  });
}

var updateInventoryView = function(myChoice) {
  var link = window.location.href;
  $.ajax({
    type: "GET",
    url: link,
    dataType: "script",
    data: { choice: myChoice },
    success: function(data) {
    checkboxClicked(choice);
    }
  });
}

var choice;

$(document).on('turbolinks:load', function() {
  $("#all-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView();
    checkboxClicked(choice);

  });
  $("#rock-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("rock");
    choice = "rock";
    checkboxClicked(choice);

  });
  $("#paper-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("paper");
    choice = "paper";
    checkboxClicked(choice);

  });
  $("#scissors-bought-skins").click(function(event) {
    event.preventDefault();
    updateInventoryView("scissors");
    choice = "scissors";
    checkboxClicked(choice);

  });
  checkboxClicked(choice);
});
