$(document).ready(function(){
  $("form").on("click", ".remove_fields", function(){
    $(this).prev("input[type=hidden]").val(1);
    $(this).parent().parent().hide();
  });

  $("form").on("click", ".add_fields", function(){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
  });
});
