$ ->
  $('.currency_symbol').tooltip
    placement: 'left'
    delay: 500
    container: 'body'

  # Tooltip for untranslated text
  $('.foreign_language').popover(
    html: true
    placement: "bottom"
    container: "body"
    content: 'This text has not yet been translated. <a href="http://www.theworkingworld.org/us/contact-us">Contact us</a> if you\'d like to help with translation.'
  ).click (e) ->
    # Prevent rowlink from firing when clicking to show tooltip
    e.stopPropagation()
