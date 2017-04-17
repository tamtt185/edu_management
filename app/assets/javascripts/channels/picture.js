$(document).ready(function() {
  $('#avatar_image').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Kích thước tối đa là 5MB. Hãy chọn ảnh có kích thước nhỏ hơn!');
    }
  });
});
