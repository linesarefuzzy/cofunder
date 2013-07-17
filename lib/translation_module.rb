module TranslationModule
  def get_translations(table_name, column_name, id)
    translations = Translation.joins(:language).where(
      :RemoteTable => table_name,
      :RemoteColumnName => column_name,
      :RemoteID => id
    ).order('Languages.Priority')
    
    translations_hash = {}
    translations.each do |t|
      translations_hash[t.language.code] = t.translated_content
    end
    return translations_hash
  end    

  def get_translation(table_name, column_name, id, language_code='EN')
    translations = get_translations(table_name, column_name, id)
    content = translations[language_code] || translations.first[1]
    return content
  end
  
  include ActionView::Helpers::NumberHelper
  def currency_format(amount, country, tooltip=true)
    currency = Currency.where(:Country => country).first
    symbol = currency.symbol
    symbol = symbol.sub(/\$/, ' $') # add space before $ (pretty)
    if tooltip
      symbol = %Q(<a href="#" onclick="return false" data-toggle="tooltip" class="currency_symbol" title="#{currency.name}s">#{symbol}</a> )
    end
    return number_to_currency(amount, :unit => symbol)
  end
end