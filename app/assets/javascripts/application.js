// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
<<<<<<< HEAD
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .
//= require cable

$(document).on("turbolinks:load", function() {
  if (window.location.pathname != "/users" && window.location.pathname != "/friends") {
    $("#my_search").removeAttr("data-remote");
    $("#my_search").attr("action", "/users");
  }
});
=======
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
>>>>>>> 507e1839bd0bd2bd5110eb622a62489feade8e2f
