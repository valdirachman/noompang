
document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  $(function(){
  var button = $('#driver_check_post');
  button.attr('disabled', 'disabled');
  $('#driver_check').change(function(e){
    if (this.checked) {
      button.removeAttr('disabled');
    } else {
      button.attr('disabled', 'disabled');
    }
  })
})

})
})
