// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function() {
  var notifications = $("[data-behavior='notifications']");
  if (notifications.length > 0) {
    $.ajax({
      type: "GET",
      url: "/notifications.json",
      dataType: "JSON",
      success: function(data) {
        var items = "";
        for (var i = 0; i < data.length; i++) {
          var n = data[i];
          var item = `<li class="dropdown-item"> ${n.image}${n.actor} ${n.action}`;
          if (n.action == "sent you a friend request!" || n.action == "challenged you!") {
            item += `<div style="float:right">`;
            item += `<a href="${n.url}" data-method="patch" class="btn btn-primary btn-xs">Accept</a>`;
            item += `<a href="${n.url}" data-method="delete" class="btn btn-danger btn-xs">Decline</a>`;
            item += `</div>`;
          }
          else if (n.action == "accepted your challenge!") {
            item += `<div style="float:right">`;
            item += `<a href="${n.url}" class="btn btn-primary btn-xs">Play</a>`;
            item += `</div>`;
          }
          item += "<br /> </li>";
          items += item;
        }
        if (data.length > 0) {
          items += "<a class='dropdown-item' href='/notifications'> See all </a>";
          $("[data-behavior='notification_items']").html(items);
          $("[data-behavior='notifications_count']").text(data.length);
        }
        else {
          console.log("nothing");
          document.getElementById("notifications_dropdown").disabled = true;
        }
      }
    });
  }
});
