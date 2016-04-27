$(document).ready(function(){
  $("select").material_select();

  $("form").on("click", ".remove_fields", function(event){
    $(this).prev("input[type=hidden]").val(true);
    $(this).parent().parent().parent().hide();
    event.preventDefault();
  });

  $("form").on("click", ".add_fields", function(event){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
    event.preventDefault();
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

function changeCheckBox(id){
  $("input[type='checkbox']").prop("checked", false);
  document.getElementById(id).checked = true;
}
