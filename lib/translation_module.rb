module TranslationModule
  def get_translation(table_name, column_name, id, language_code='EN')
    translations = Translation.where(
      :RemoteTable => table_name,
      :RemoteColumnName => column_name,
      :RemoteID => id
    )
    begin
      # content = translations.joins(:language).where(:languages => {:Code => language_code}).first.TranslatedContent
      content = translations.joins(:language).where('Languages.Code' => language_code).first.TranslatedContent
    rescue NoMethodError
      begin
        content = translations.joins(:language).order('Languages.Priority').first.TranslatedContent
      rescue NoMethodError
        return ''
      end
    end
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