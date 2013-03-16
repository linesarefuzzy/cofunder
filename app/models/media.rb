class Media < ActiveRecord::Base
  self.table_name = 'Media'
  attr_accessible :ContextID, :ContextTable, :Description, :MediaPath, :MemberID, :Priority
end
