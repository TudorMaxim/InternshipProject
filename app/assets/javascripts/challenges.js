$(document).ready(function() {

  $("#rock-button").click(function(event) {
    event.preventDefault();
    document.getElementById("paper-button").disabled = true;
    document.getElementById("scissors-button").disabled = true;

    var link = $(this).attr('href') + ".json";
    $.ajax({
      type: "POST",
      url: link,
      data: { _method: "PATCH",
              choice: "rock" },
      dataType: "JSON",
      success: function(result) {
        alert("AJAX WORKED!!");
      },
      error: function(result) {
        alert("Did not work!");
      }
    });
    //debugger;

  });

  $("#paper-button").click(function(event) {
    event.preventDefault();
    document.getElementById("rock-button").disabled = true;
    document.getElementById("scissors-button").disabled = true;

    var link = $(this).attr('href') + ".json";
    $.ajax({
      type: "POST",
      url: link,
      data: { _method: "PATCH",
              choice: "paper" },
      dataType: "JSON",
      success: function(result) {
        alert("AJAX WORKED!!");
      },
      error: function(result) {
        alert("Did not work!");
      }
    });
  });

  $("#scissors-button").click(function(event) {
    event.preventDefault();
    document.getElementById("rock-button").disabled = true;
    document.getElementById("paper-button").disabled = true;

    var link = $(this).attr('href') + ".json";
    $.ajax({
      type: "POST",
      url: link,
      data: { _method: "PATCH",
              choice: "scissors" },
      dataType: "JSON",
      success: function(result) {
        alert("AJAX WORKED!!");
      },
      error: function(result) {
        alert("Did not work!");
      }
    });
  });

});
