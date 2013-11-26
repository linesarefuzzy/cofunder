module TranslationsHelper
  def html_format(text)
    text.gsub("\n", '<br>').html_safe
  end
end
