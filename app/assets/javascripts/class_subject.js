$(document).on("turbolinks:load", function() {
  $('.selected-subject').on('change',function(e) {
    var selected_subject_id = $(this).val();
    var data = {selected_subject_id: selected_subject_id};
    $.get($(this).attr('action'), data, null, 'script');
  });
});
