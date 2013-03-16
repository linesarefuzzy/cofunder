class Currency < ActiveRecord::Base
  attr_accessible :Country, :Description, :Name, :Symbol
end
