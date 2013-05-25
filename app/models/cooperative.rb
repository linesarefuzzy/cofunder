class Cooperative < ActiveRecord::Base
  include Legacy
  attr_accessible :Name
  has_many :Loans, :foreign_key => 'CooperativeID'
end
