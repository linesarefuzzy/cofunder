require 'translation_module'

class Loan < ActiveRecord::Base
  include TranslationModule

  self.primary_key = 'ID'
  belongs_to :Cooperative, :foreign_key => 'CooperativeID'
  attr_accessible :Amount, :Nivel, :Rate, :SigningDate
  
  def get_short_description(language_code="EN")
    return get_translation('Loans', 'ShortDescription', self.ID, language_code)
  end

	def get_description(language_code='EN')
		return get_translation('Loans', 'Description', self.ID, language_code)
  end
end
