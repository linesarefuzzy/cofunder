class Division < ActiveRecord::Base
  self.table_name = 'Divisions'
  attr_accessible :Country, :Name
end
