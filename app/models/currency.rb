class Currency < ActiveRecord::Base
  include Legacy
  attr_accessible :Country, :Description, :Name, :Symbol
end
