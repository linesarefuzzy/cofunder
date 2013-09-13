module TranslationModule
  # add translation method to all models that include this module
  extend ActiveSupport::Concern
  included do
    def translation(column_name, language_code='EN')
      get_translation(self.class.table_name.camelize, self.id, column_name, language_code)
    end
  end

  def get_translation(table_name, id, column_name, language_code='EN')
    translations = Translation.joins(:language).where(
      :RemoteTable => table_name,
      :RemoteColumnName => column_name,
      :RemoteID => id
    )
    t = translations.where('Languages.Code' => language_code).try(:first) || 
        translations.order('Languages.Priority').try(:first)
    # t.css_class = (t.language.code == language_code ? 'home_language' : 'foreign_language')
    return t
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

  # def get_translations(table_name, column_name, id)
  #   translations = Translation.joins(:language).where(
  #     :RemoteTable => table_name,
  #     :RemoteColumnName => column_name,
  #     :RemoteID => id
  #   ).order('Languages.Priority')
    
  #   translations_hash = {}
  #   translations.each do |t|
  #     translations_hash[t.language.code] = t.translated_content
  #   end
  #   return translations_hash
  # end    

  # def get_translation(table_name, column_name, id, language_code='EN')
  #   translations = get_translations(table_name, column_name, id)
  #   content = translations[language_code] || translations.first[1]
  #   return content
  # end

end