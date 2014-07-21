module TranslationModule
  # add translation method to all models that include this module
  extend ActiveSupport::Concern
  included do
    def translation(column_name)
      get_translation(self.class.table_name.camelize, self.id, column_name)
    end
  end

  def get_translation(table_name, id, column_name)
    translations = Translation.joins(:language).where(
      :RemoteTable => table_name,
      :RemoteColumnName => column_name,
      :RemoteID => id
    )
    return translations.where('Languages.Code' => I18n.locale.to_s.upcase || 'EN').try(:first) ||
           translations.order('Languages.Priority').try(:first)
  end

  include ActionView::Helpers::NumberHelper
  def currency_format(amount, currency, tooltip=true)
    symbol = currency.symbol
    symbol = symbol.sub('$', ' $') # add space before $ (pretty)
    if tooltip
      symbol = %Q(<a href="#" onclick="return false" data-toggle="tooltip" class="currency_symbol" title="#{currency.name}s">#{symbol}</a> )
    end
    return number_to_currency(amount, :unit => symbol)
  end
end
