class Translation < ActiveRecord::Base
  include Legacy
  belongs_to :Language, :foreign_key => 'Language'
  attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
end
