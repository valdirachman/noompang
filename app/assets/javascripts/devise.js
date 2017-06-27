document.addEventListener("turbolinks:load", function() {
  if ($(window).width() < 1050) {
      $('#container-devise').removeClass('container');
  } else {
      $('#container-devise').addClass('container');
  }
});
