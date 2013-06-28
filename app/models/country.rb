class Country < ActiveRecord::Base
  include Legacy
  belongs_to :language, :foreign_key => 'LanguageID'
  attr_accessible :Name
end
