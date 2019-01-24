//= require application

$(document).on("turbolinks:load", function () {
  $(document).ready(function () {
    $("body").click(function () {
      $(".alert").alert("close");
    });
  });
});
