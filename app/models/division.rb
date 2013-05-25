class Division < ActiveRecord::Base
  include Legacy
  attr_accessible :Country, :Name
end
