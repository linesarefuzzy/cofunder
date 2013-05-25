class Media < ActiveRecord::Base
  include Legacy
  attr_accessible :ContextID, :ContextTable, :Description, :MediaPath, :MemberID, :Priority
end
