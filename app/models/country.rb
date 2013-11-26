class Country < ActiveRecord::Base
  include Legacy
  belongs_to :language, :foreign_key => 'LanguageID'
  attr_accessible :Name
  
  def default_currency
    Currency.where(:Country => self.name).first
  end
end
