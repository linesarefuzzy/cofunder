class Media < ActiveRecord::Base
  attr_accessible :ContextID, :ContextTable, :Description, :MediaPath, :MemberID, :Priority
end
