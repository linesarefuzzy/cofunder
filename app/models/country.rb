class Country < ActiveRecord::Base
  self.table_name = 'Countries'
  self.primary_key = 'ID'

  belongs_to :Language, :foreign_key => 'LanguageID'
  attr_accessible :Name
end
