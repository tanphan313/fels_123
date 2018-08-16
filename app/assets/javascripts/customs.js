$(document).ready(function(){
  $("select").material_select();

  $("form").on("click", ".remove_fields", function(event){
    $(this).prev("input[type=hidden]").val(true);
    $(this).parent().parent().parent().hide();
    event.preventDefault();

    validateWordForm();
  });

  $("form").on("click", ".add_fields", function(event){
    var time = new Date().getTime();
    var regexp = new RegExp($(this).data("id"), "g");
    $(this).before($(this).data("fields").replace(regexp, time));
    event.preventDefault();

    validateWordForm();
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


  $("#word-form-update").change(function(){
    if($(this).find("#word_content").val().length == 0){
      $("#error-content-answer").html("Word content can not be blank");
    }else{
      $("#error-content-answer").html(null);
    }
    validateWordForm();
  });

  $("form").on("click", ".checkbox-changed", function(){
    $("input[type='checkbox']").prop("checked", false);
    $(this).prop("checked", true);
  });

});

function validateWordForm(){
  var number_of_answer = 0
  var number_of_content_answer = 0;
  var number_of_correct_answer = 0;
  $(".word_answer_form").each(function(){
    if($(this).find(".s1").find("input:hidden").val() == "false"){
      if($(this).find(".s9").find("input:text").val().length > 0){
        number_of_content_answer++;
      }
      number_of_answer++;
      number_of_correct_answer += $(this).find(".s2").find("input:checked").length;
    }
  });
  if(number_of_answer < 2 || number_of_content_answer < 2){
    $("#error-number-word-answer").html("Word answer Must have at least two answers");
  }else{
    $("#error-number-word-answer").html(null);
  }
  if(number_of_correct_answer < 1){
    $("#error-number-correct-answer").html("Word answer Must have one answer correct");
  }else{
    $("#error-number-correct-answer").html(null);
  }
}
