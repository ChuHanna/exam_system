$(document).ready(function() {
  $('input[type="radio"][name="message[repeat_type]"]').change(function(){
    $('#message_start_date, #message_end_date, #message_time_to_send').prop('disabled', this.value == 'now');
    switch(this.value) {
      case 'weekly':
        $('.show-day-of-week').addClass('form-group--inactive');
        $('.show-calendar, .show-calendar-month').removeClass('form-group--inactive');
        $('#time-repeate_type, #start-repeate_type').addClass('required');
        break;
      case 'monthly':
        $('.show-calendar-month').addClass('form-group--inactive');
        $('.show-day-of-week, .show-calendar').removeClass('form-group--inactive');
        $('#time-repeate_type, #start-repeate_type').addClass('required');
        break;
      case 'custom':
        $('.show-calendar').addClass('form-group--inactive');
        $('.show-day-of-week, .show-calendar-month').removeClass('form-group--inactive');
        $('#time-repeate_type, #start-repeate_type').addClass('required');
        break;
      case 'daily':
        $('#time-repeate_type').addClass('required');
        $('.show-calendar, .show-day-of-week, .show-calendar-month').removeClass('form-group--inactive');
        break;
      default:
        $('.show-calendar, .show-day-of-week, .show-calendar-month').removeClass('form-group--inactive');
        $('#time-repeate_type, #start-repeate_type').removeClass('required');
        break;
    }
  });
});
