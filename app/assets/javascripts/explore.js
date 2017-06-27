// Explore

//======== RECOMMENDED FRIENDS =======//
document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#addgevin').click(function(){
  $('#gevin').hide(500);
  $('#ginad').fadeIn(400);
  $('#addgevin').removeClass('btn-success');
  $('#addgevin').addClass('btn-primary');
  $('#gevin button').text('Added');
})
})
})


document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#addhaffi').click(function(){
  $('#addhaffi').removeClass('btn-success');
  $('#addhaffi').addClass('btn-primary');
  $('#haffi button').text('Added');
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#addarvi').click(function(){
  $('#haffi').hide(500);
  $('#addarvi').removeClass('btn-success');
  $('#addarvi').addClass('btn-primary');
  $('#arvi button').text('Added');
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#addginad').click(function(){
  $('#arvi').hide(500);
  $('#ginad').hide(500);
  $('#haffi').hide(500)
  $('#addginad').removeClass('btn-success');
  $('#addginad').addClass('btn-primary');
  $('#ginad button').text('Added');
  $('.all-clicked').fadeIn(200);
})
})
});
//========POST RIDES==========//


document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
  $('#post').click(function () {
  var from = $('#from').val();
  $('.post-from').html(from);

  var to = $('#to').val();
  $('.post-to').html(to);

  var note = $('#note').val();
  $('.post-note').html(note);
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#post').click(function () {
  $('#post-ride').fadeIn(400);
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#delete-post').click(function(){
  $('#post-ride').hide(500);
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#delete-post2').click(function(){
  $('#repost-ride').hide(500);
})
})
});

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$('#repost-post').click(function(){
  $('#repost-ride').fadeIn(400);
})
})
});

//scroll to ID

document.addEventListener("turbolinks:load", function() {
$(document).ready(function(){
$("#scroll-to-how").click(function() {
    $('html, body').animate({
        scrollTop: $("#how-it-works").offset().top
    }, 600);
});
});
});
