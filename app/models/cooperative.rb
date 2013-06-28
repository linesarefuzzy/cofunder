class Cooperative < ActiveRecord::Base
  include Legacy
  attr_accessible :Name
  has_many :loans, :foreign_key => 'CooperativeID'
end
