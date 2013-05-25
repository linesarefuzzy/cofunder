class Language < ActiveRecord::Base
  include Legacy
  attr_accessible :Code, :Name, :Priority
end
