$(function () {
  // Enable link to tab
  var hash = document.location.hash;
  var prefix = "_";
  if (hash)
    $('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
  else
    $('.nav-tabs a:first').tab('show'); // Select first tab

  // Initiate slideshow
  $('.carousel-inner .item').first().addClass('active')
  $('.carousel-indicators li').first().addClass('active')
  $('.carousel').carousel()
  
  // Show Logs/Hide Logs toggle
  $('.logs').on('show', function() {
    $('#show-' + this.id).html('Hide Logs')
  })
  $('.logs').on('hide', function() {
    $('#show-' + this.id).html('Show Logs')
  })

  // More/Less toggle for log details
  $('.log-details').on('show', function() {
    $('#show-' + this.id).html('Less')
  })
  $('.log-details').on('hide', function() {
    $('#show-' + this.id).html('More')
  })
})

