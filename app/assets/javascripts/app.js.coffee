$ ->
  $('.currency_symbol').tooltip
    placement: 'left'
    delay: 500
    container: 'body'

  # Tooltip for untranslated text
  $('.foreign_language').popover
    html: true
    placement: "bottom"
    container: "body"
    content: 'This text has not yet been translated to your language. <a href="/us/contact-us">Contact us if you\'d like to help with translation.</a>'
