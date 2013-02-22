class Cooperative < ActiveRecord::Base
  self.primary_key = 'ID'
  attr_accessible :Name
  has_many :Loans, :foreign_key => 'CooperativeID'
end
