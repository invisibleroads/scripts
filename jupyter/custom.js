$([IPython.events]).on('app_initialized.NotebookApp', function () {
  $(window).resize(function() {
    $('#site').height('100%');
  });
  setTimeout(function() {
    $('#site').height('100%');
  }, 1000);
  setTimeout(function() {
    $('#header').hide();
  }, 10000);
  $('#maintoolbar').hide();
});
