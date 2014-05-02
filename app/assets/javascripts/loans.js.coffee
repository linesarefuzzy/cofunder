$ ->

  # Enable link to tab
  hash = document.location.hash
  prefix = "_"
  if hash
    $(".nav-tabs a[href=" + hash.replace(prefix, "") + "]").tab "show"
  else # Select first tab
    $(".nav-tabs a:first").tab "show"

  # Initiate slideshow
  $(".carousel-inner .item").first().addClass "active"
  $(".carousel-indicators li").first().addClass "active"
  $(".carousel").carousel()

  # Show Logs/Hide Logs toggle
  $(".logs").on "show", ->
    $("#show-" + @id).html "Hide Logs"
  $(".logs").on "hide", ->
    $("#show-" + @id + ".collapsed").html "Show Logs"

  # More/Less toggle for log details
  $(".log-details").on "show", ->
    $("#show-" + @id).html "Less"
  $(".log-details").on "hide", ->
    $("#show-" + @id + ".collapsed").html "More"

  # Tooltip for untranslated text
  $('.foreign_language').popover(
    html: true
    placement: "bottom"
    content: 'This text has not yet been translated to your language. <a href="/us/contact-us">Contact us if you\'d like to help with translation.</a>'
  )
