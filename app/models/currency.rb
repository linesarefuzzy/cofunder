class Currency < ActiveRecord::Base
  include Legacy
  attr_accessible :Country, :Description, :Name, :Symbol
  
  def country
    Country.where(name: self.Country).first
  end
end
