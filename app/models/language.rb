class Language < ActiveRecord::Base
  self.table_name = 'Languages'
  attr_accessible :Code, :Name, :Priority
end
