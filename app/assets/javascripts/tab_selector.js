document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){



      $('#tab1').click(function(){
      $('#tab2, #tab3').removeClass('post-tab-slider');
      $('#tab1').addClass('post-tab-slider');
      });

      $('#tab2').click(function(){
      $('#tab1, #tab3').removeClass('post-tab-slider');
      $('#tab2').addClass('post-tab-slider');
      });

      $('#tab3').click(function(){
      $('#tab1, #tab2').removeClass('post-tab-slider');          $('#tab3').addClass('post-tab-slider');
      });

  });
});
