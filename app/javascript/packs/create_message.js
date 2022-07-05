$(document).ready(function() {
  $('#message_mentions').select2();

  $(document).on('change', '#message_workspace_id', function(){
    var workspace_id = $(this).val();
    $('#message_slack_channel').val(null).trigger('change');
    let options = '';

    $.ajax({
      url: '/slack_channels',
      method: 'GET',
      dataType: 'json',
      data: {workspace_id: workspace_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
        $('#message_channel_id').html(options).trigger('change');
      },
      success: function (response) {
        const channels = response.channels;
        channels.forEach(item => {
          options +=
            `<option value='${item['id']}'>
              ${item['name']}
            </option>`
        })
        $('#message_channel_id').html(options).trigger('change');
      }
    });
  });

  $(document).on('change', '#message_channel_id', function(){
    var workspace_id = $('#message_workspace_id').val();
    var channel_id = this.value;

    $('#message_mentions').val(null).trigger('change');
    let options = '';

    $.ajax({
      url: '/slack_members',
      method: 'GET',
      dataType: 'json',
      data: {channel_id: channel_id, workspace_id: workspace_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
        $('#message_mentions').html(options).trigger('change');
      },
      success: function (response) {
        const members = response.members;

        members.forEach(item => {
          options +=
            `<option value='${item['id']}'>
              ${item['name']}
            </option>`
        })
        $('#message_mentions').html(options).trigger('change');
      }
    });
  });
});
