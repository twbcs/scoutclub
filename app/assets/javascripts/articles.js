$("#comment").on("click",function(){
  $(this).addClass("disabled").val('傳送中')
});
$(function(){
  $('#comment_content').keyup(function(){
    if ($(this).val().length < 10 ) {
      $('#comment').addClass("disabled");
    } else {
      $('#comment').removeClass("disabled");
    }
  });
});
