$([IPython.events]).on('app_initialized.NotebookApp', function () {
  $('#maintoolbar').hide();
  setTimeout(function() {
    $('#site').height('100%');
  }, 500);
  setTimeout(function() {
    $('#header').hide();
  }, 5000);
});
