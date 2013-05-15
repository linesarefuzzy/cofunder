require 'translation_module'
require 'media_module'

class Loan < ActiveRecord::Base
  include TranslationModule, MediaModule, ActionView::Helpers::NumberHelper

  self.table_name = 'Loans'
  self.primary_key = 'ID'
  belongs_to :Cooperative, :foreign_key => 'CooperativeID'
  belongs_to :Division, :foreign_key => 'SourceDivision'
  attr_accessible :Amount, :Nivel, :Rate, :SigningDate
  
  def name
    if self.Cooperative then "Project with " + self.Cooperative.Name 
    else "Project " + self.ID.to_s end
  end
  
  def country; self.Division.Country end
  
  def get_short_description(language_code="EN")
    return get_translation('Loans', 'ShortDescription', self.ID, language_code)
  end

  def get_description(language_code='EN')
    return get_translation('Loans', 'Description', self.ID, language_code)
  end
  
  def picture_paths(limit=1)
    return get_picture_paths('Loans', self.ID, limit) || get_picture_paths('Cooperatives', self.Cooperative.ID, limit)
  end
  
  def main_picture
    return self.picture_paths.try(:first)
  end
    
  def amount_formatted
    symbol = Currency.where(:Country => self.country).first.Symbol
    symbol = symbol.sub(/\$/, ' $') # add space before $ (pretty)
    return number_to_currency(self.Amount, :unit => symbol)
  end
  
  def project_events(order_by="Completed IS NULL, Completed, Date")
    return ProjectEvent.where("lower(ProjectTable) = 'loans' and ProjectID = ?", self.ID).order(order_by)
  end
end
