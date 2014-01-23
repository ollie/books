$(function() {
  $('a[data-confirm]').on('click', function() {
    var $link   = $(this),
        message = $link.data('confirm');

    return confirm(message);
  });
});

$(function() {
  var Bar = function($bars)
  {
    this.$bars = $bars;
  };

  Bar.prototype.bind = function()
  {
    this.$bars.each( $.proxy(this.bindItem, this) );
  };

  Bar.prototype.bindItem = function(index, item)
  {
    var $bar = $(item);

    $bar.on('mousemove',  $.proxy(this.overItem, this));
    $bar.on('mouseleave', $.proxy(this.restoreItem, this));
    $bar.on('click',      $.proxy(this.click, this));
  }

  Bar.prototype.overItem = function(event)
  {
    var $bar           = $(event.currentTarget),
        $progress      = $bar.find('.book-item-bar-progress'),
        $page          = $bar.parents('.book-item').find('.book-item-page'),
        $percentage    = $bar.parents('.book-item').find('.book-item-percent');

        // Mouse coordinate from left side of the screen
        mousePosX      = event.clientX,
        // Item's left coordinate from the left side of the screen
        itemOffsetX    = $bar.offset().left,
        // Difference is the position in the bar from the left
        hoveredWidth   = mousePosX - itemOffsetX,
        itemWidth      = $bar.width(),
        hoveredRatio   = hoveredWidth / itemWidth,
        hoveredPercent = hoveredRatio * 100,
        roundedPercent = (Math.round(hoveredPercent * 10) / 10),

        // Page
        page           = $bar.attr('data-page'),
        pages          = $bar.attr('data-pages'),
        hoveredPage    = Math.round(hoveredRatio * pages);

    $progress.width(hoveredPercent + '%');
    $bar.attr('data-new-page', hoveredPage);
    $page.text(hoveredPage);
    $percentage.text('(' + roundedPercent + '%)');
  };

  Bar.prototype.restoreItem = function(event)
  {
    var $bar            = $(event.currentTarget),
        $progress       = $bar.find('.book-item-bar-progress'),
        $page           = $bar.parents('.book-item').find('.book-item-page'),
        $percentage     = $bar.parents('.book-item').find('.book-item-percent'),
        originalPage    = $bar.attr('data-page'),
        originalPercent = $bar.attr('data-percentage'),
        roundedPercent  = (Math.round(originalPercent * 10) / 10);

    $progress.width(originalPercent + '%');
    $page.text(originalPage);
    $percentage.text('(' + roundedPercent + '%)');
  };

  Bar.prototype.click = function(event)
  {
    var $bar  = $(event.currentTarget),
        $page = $bar.parents('.book-item').find('.book-item-page'),
        id    = $bar.attr('data-id'),
        page  = $bar.attr('data-new-page'),
        url   = '/books/' + id + '/page/' + page;

    location.href = url;
  };

  var bar = new Bar( $('.book-item-bar') );
  bar.bind();
});
