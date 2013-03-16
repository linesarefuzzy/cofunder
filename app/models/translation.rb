class Translation < ActiveRecord::Base
  self.table_name = 'Translations'
  belongs_to :Language, :foreign_key => 'Language'
  attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
end
