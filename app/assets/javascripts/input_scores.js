$(document).ready(function() {
  $('.save-score').on('click',function(e) {
    var sub_score_id = this.dataset.sub_score_id;
    var data = {};
    $(".tbody-score tr.student-score").each(function(){
      var id = this.dataset.id;
      var score = 0;
      score = $('.student-score-'+ id + "-" + sub_score_id).text().replace(/\n|\r/g, "").replace(/\s+/g, '');
      if(!(($.isNumeric(score))&&(parseFloat(score) >= 0)&&(parseFloat(score) <= 10))){
        alert("Số nhập vào không hợp lệ");
        window.location.href = '';
        return
      }
      data[id] = {is_confirm: 0, student_id: id, sub_score_id: sub_score_id, score: score};
      e.preventDefault();
    })
    $.ajax({
      type: 'post',
      url: $(this).attr('action'),
      data: {student_scores: JSON.stringify(data)},
    });
    e.preventDefault();
  });

  $('.confirm-score').on('click',function(e) {
    var sub_score_id = this.dataset.sub_score_id;
    if (confirm("Xác nhận điểm?"))
     { 
        var data = {};
        $(".tbody-score tr.student-score").each(function(){
          var id = this.dataset.id;
          var score = 0;
          score = $('.student-score-'+ id + "-" + sub_score_id).text().replace(/\n|\r/g, "").replace(/\s+/g, '');
          if(!(($.isNumeric(score))&&(parseFloat(score) >= 0)&&(parseFloat(score) <= 10))){
            alert("Số nhập vào không hợp lệ");
            window.location.href = '';
            return
          }
          data[id] = {is_confirm: 1, student_id: id, sub_score_id: sub_score_id, score: score};
          e.preventDefault();
        })
        $.ajax({
          type: 'post',
          url: $(this).attr('action'),
          data: {student_scores: JSON.stringify(data)},
        });
        e.preventDefault();
     }
    else
      {
        window.location.href = '';
      }
  });

   $('.admin-edit-score').on('click',function(e) {
    var sub_score_id = this.dataset.sub_score_id;
    if (confirm("Xác nhận chỉnh sửa điểm?"))
     { 
        var data = {};
        $(".tbody-score tr.student-score").each(function(){
          var id = this.dataset.id;
          var score = 0;
          score = $('.student-score-'+ id + "-" + sub_score_id).text().replace(/\n|\r/g, "").replace(/\s+/g, '');
          if(!(($.isNumeric(score))&&(parseFloat(score) >= 0)&&(parseFloat(score) <= 10))){
            alert("Số nhập vào không hợp lệ");
            window.location.href = '';
            return
          }
          data[id] = {is_confirm: 1, student_id: id, sub_score_id: sub_score_id, score: score};
          e.preventDefault();
        })
        $.ajax({
          type: 'post',
          url: $(this).attr('action'),
          data: {student_scores: JSON.stringify(data)},
        });
        e.preventDefault();
     }
    else
      {
        window.location.href = '';
      }
  });
});
