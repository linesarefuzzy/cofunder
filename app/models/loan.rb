require 'translation_module'
require 'media_module'

class Loan < ActiveRecord::Base
  include TranslationModule, MediaModule, ActionView::Helpers::NumberHelper

  self.table_name = 'Loans'
  self.primary_key = 'ID'
  belongs_to :Cooperative, :foreign_key => 'CooperativeID'
  belongs_to :Division, :foreign_key => 'SourceDivision'
  attr_accessible :Amount, :Nivel, :Rate, :SigningDate
  
  def get_short_description(language_code="EN")
    return get_translation('Loans', 'ShortDescription', self.ID, language_code)
  end

  def get_description(language_code='EN')
    return get_translation('Loans', 'Description', self.ID, language_code)
  end
  
  def picture_paths
    return get_picture_paths('Loans', self.ID) || get_picture_paths('Cooperatives', self.Cooperative.ID)
  end
  
  def thumb_path
    paths = self.picture_paths
    if paths 
      return paths[:thumb]
    end
  end
  
  def amount_formatted
    country = self.Division.Country
    symbol = Currency.where(:Country => country).first.Symbol
    symbol = symbol.sub(/\$/, ' $') # add space before $ (pretty)
    return number_to_currency(self.Amount, :unit => symbol)
  end
end
