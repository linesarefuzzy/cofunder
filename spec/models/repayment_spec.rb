require 'rails_helper'

describe Repayment, :type => :model do
  it 'has a valid factory' do
    expect(create(:repayment)).to be_valid
  end
end
