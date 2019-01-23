$(document).on("turbolinks:load", function () {
  $(document).ready(function () {
    $("body").click(function () {
      $(".alert").alert("close");
    });
    $("#edit-admin .star-password").remove();
    $("#edit-admin .star-password-confirmation").remove();

    $(".listing-table").on("click", ".remove", function () {
      var id = $(this).data("id");
      var url = $(this).data("url");
      $('#btn-confirm-delete').attr('href', url + "/" + id);
    });

    icheck();
  });

  function icheck() {
    if ($(".icheck-me").length > 0) {
      $(".icheck-me").each(function () {
        var $el = $(this);
        var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
          color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
        var opt = {
          checkboxClass: 'icheckbox' + skin + color,
          radioClass: 'iradio' + skin + color,
        };
        $el.iCheck(opt);
      });
    }
  }
});
