$(document).ready(function(){
  var checkTimer;
  
  function changeStatus() {
    checkTimer = setInterval(checkStatus, 1000);
  }

  function checkStatus() {
    $.get('/api', function(data) {
      console.log(data);
      $('.status').css('background-color', ((data.occupied) ? 'red' : 'green'));
    });
  }

  changeStatus();
});
