$(function() {
  $('a[data-confirm]').on('click', function() {
    var $link = $(this),
        message = $link.data('confirm');

    return confirm(message);
  });
});
