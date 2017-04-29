$(document).ready(function() {
  $('#calculate').click(function() {
    $.post('/calculate', { 'expense' : $('#expense').val(),
                           'income' : $('#income').val(),
                           'amount' : $('#amount').val(),
                           'base_rate' : $('#base-rate').val(),
                           'increment' : $('#increment').val() });
    location.reload();
  });
});
