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
})

