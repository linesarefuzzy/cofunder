class Translation < ActiveRecord::Base
  include Legacy
  belongs_to :language, :foreign_key => 'Language'
  attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
end
