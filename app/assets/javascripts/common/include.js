$(document).on('turbolinks:load', function() {
  jQuery(document).on('change', '#file-upload', function(e) {
    var preview = document.getElementById("img-upload");
    var file    = document.querySelector('input[type=file]').files[0];
    var reader  = new FileReader();
    reader.onloadend = function () {
      preview.src = reader.result;
    }
    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.src = "";
    }
  });

  App.init();

  turbolink_app();

  $('.select-select2').select2();

  $('.input-slider').slider();
});

var turbolink_app = function(){
  $(document).ready(function() {
      $('.notify').slideDown(300, function() {
      window.setTimeout(function() {
        $('.notify').slideUp(300, function() {
          $('.notify').hide();
        });
      }, 3000);
    });
    $('.close-message').click(function(){
      $('.notify').slideUp(300, function() {
        $('.notify').hide();
      });
    });

    $('.join-club-button').click(function(){
      $('#new_user_club').submit();
    });

    $('.btn-comment').click(function(){
      $('.form-comment-'+$(this).attr('id')).slideDown();
    });

    $(function () {
      var find_list = $('.load-more-toggle');
      for(i = 0; i < find_list.length; i++){
        $('.' + find_list[i].id + ' li').slice(0, 5).show();
      }
      $('.load-more-toggle').on('click', function(e) {
        e.preventDefault();
        var list = e.target.id;
        $('.' + list + ' li:hidden').slice(0, 5).slideDown();
        $('html,body').animate({
          scrollTop: $(this).offset().top
        }, 500);
      });
    });

    $(function () {
      var find_list = $('.load-more-comment');
      for(i = 0; i < find_list.length; i++){
        $('.' + find_list[i].id + ' dt').slice(0, 2).show();
      }
      $('.load-more-comment').on('click', function(e) {
        e.preventDefault();
        var list = e.target.id;
        $('.' + list + ' dt:hidden').slice(0, 5).slideDown();
      });
    });

    var count_notify = function(){
      $('.notification_count').text($('.notification-un_read').length)
      if($('.notification_count').text() == '0'){
        $('.notification_count').fadeOut('slow');
      }
    }

    $('.notifiglobe').click(function(){
      count_notify();
      $('.notificationContainer').fadeToggle(300);
      return false;
    });

    $(document).click(function(){
      count_notify();
      $('.notificationContainer').hide();
    });

    $('.hide-notification').click(function(){
      count_notify();
      $('.notificationContainer').hide();
    });

    $('.notificationContainer').click(function(){
      count_notify();
      return false
    });

    $('.notifyBody').click(function(){
      $.post('/activities', {id: $(this).attr('data-id')}, function(data){});
      window.open($(this).attr('data-link'), '_self');
    });

    $('.notificationsBody').slimScroll({
      wheelStep: 20
    });
  });
};
