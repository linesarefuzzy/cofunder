class Cooperative < ActiveRecord::Base
  self.table_name = 'Cooperatives'
  self.primary_key = 'ID'
  attr_accessible :Name
  has_many :Loans, :foreign_key => 'CooperativeID'
end
