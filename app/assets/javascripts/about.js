//fade in header title
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function(){
    $('#form-section').fadeIn(1500);
  });
});

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})


//======== INDEX ============//
document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  $('#switch-signup').click(function(){
    $('#sign-in-form').show(500);
    $('#sign-up-form').hide(500);
  });
});
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
    $('#switch-signin').click(function(){
      $('#sign-in-form').hide(500);
      $('#sign-up-form').show(500);
    })
  });
});
