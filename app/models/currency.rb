class Currency < ActiveRecord::Base
  self.table_name = 'Currencies'
  attr_accessible :Country, :Description, :Name, :Symbol
end
