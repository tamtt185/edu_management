$(document).ready(function() {
  $('.save-score').on('click',function(e) {
    var sub_score_id = this.dataset.sub_score_id;
    var data = {};
    $(".tbody-score tr.student-score").each(function(){
      var id = this.dataset.id;
      var score = 0;
      score = $('.student-score-'+ id + "-" + sub_score_id).text().replace(/\n|\r/g, "").replace(/\s+/g, '');
      data[id] = {student_id: id, sub_score_id: sub_score_id, score: score};
      e.preventDefault();
    })
    $.ajax({
      type: 'post',
      url: $(this).attr('action'),
      data: {student_scores: JSON.stringify(data)},
      success: function(data) {
        if(data.status === 200) {
          alert("Nhập điểm thất bại 1");
        }
        else {
          alert("Nhập điểm thành công 2 ");
          location.reload();
        }
      },
      error: function(error) {
        alert("Nhập điểm thất bại3");
        location.reload();
      }
    });
    e.preventDefault();
  });
});
