class Translation < ActiveRecord::Base
  include Legacy

  # language column made accessible by Legacy module interferes with language method below
  remove_method :language 
  
  belongs_to :language, :foreign_key => 'Language'
  attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
end
