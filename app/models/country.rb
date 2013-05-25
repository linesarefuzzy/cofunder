class Country < ActiveRecord::Base
  include Legacy
  belongs_to :Language, :foreign_key => 'LanguageID'
  attr_accessible :Name
end
