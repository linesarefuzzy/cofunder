class Cooperative < ActiveRecord::Base
  include Legacy
  attr_accessible :Name
  has_many :loans, :foreign_key => 'CooperativeID'

  def verbose_name
    (self.name =~ /cooperative/i) ? self.name : "#{self.name} Cooperative"
  end
end
