class Translation < ActiveRecord::Base
  belongs_to :Language, :foreign_key => 'Language'
  attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
end
