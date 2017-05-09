$(document).ready(function() {
  $('#subject_search').on('keyup',function(e) {
    var subject_search = $(this).val();
    var data = {subject_search: subject_search};
    $.get($(this).attr('action'), data, null, 'script');
  });

  $('#student_search').on('keyup',function(e) {
    var student_search = $(this).val();
    var data = {student_search: student_search};
    $.get($(this).attr('action'), data, null, 'script');
  });

  $('#lecturer_search').on('keyup',function(e) {
    var lecturer_search = $(this).val();
    var data = {lecturer_search: lecturer_search};
    $.get($(this).attr('action'), data, null, 'script');
  });

  $('#curriculum_search').on('keyup',function(e) {
    var curriculum_search = $(this).val();
    var data = {curriculum_search: curriculum_search};
    $.get($(this).attr('action'), data, null, 'script');
  });

  $('#student_class_search').on('keyup',function(e) {
    var student_class_search = $(this).val();
    var data = {student_class_search: student_class_search};
    $.get($(this).attr('action'), data, null, 'script');
  });

  $('#class_subject_search').on('keyup',function(e) {
    var class_subject_search = $(this).val();
    var data = {class_subject_search: class_subject_search};
    $.get($(this).attr('action'), data, null, 'script');
  });
});
