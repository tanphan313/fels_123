$(document).ready(function(){
  $("select").material_select();

  $("form").on("click", ".remove_fields", function(){
    $(this).prev("input[type=hidden]").val(1);
    $(this).parent().parent().hide();
  });

  $("form").on("click", ".add_fields", function(){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
  });

  $(".show-answer").click(function(){
    $(this).next().slideToggle("medium");
  });

  var radio = $("input[type='radio']");
  var countChecked = radio.filter(":checked").length;
  $("#number-checked").html(countChecked);
  radio.change(function(){
    countChecked = radio.filter(":checked").length;
    $("#number-checked").html(countChecked);
  });
});
