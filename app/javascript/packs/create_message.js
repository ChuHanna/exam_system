$(document).ready(function() {
  $('#message_mentions').select2();

  $(document).on('change', '#question_subject_id', function(){
    var subject_id = $(this).val();
    $('#question_subject_id').val(null).trigger('change');
    let options = '';

    $.ajax({
      url: '/subject_topic',
      method: 'GET',
      dataType: 'json',
      data: {subject_id: subject_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
        $('#question_topic_id').html(options).trigger('change');
      },
      success: function (response) {
        const topics = response.topics;
        topics.forEach(item => {
          options +=
            `<option value='${item['id']}'>
              ${item['name']}
            </option>`
        })
        $('#question_topic_id').html(options).trigger('change');
      }
    });
  });
});
