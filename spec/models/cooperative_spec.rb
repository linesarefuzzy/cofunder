require 'rails_helper'

describe Cooperative, :type => :model do
  it 'has a valid factory' do
    expect(create(:cooperative)).to be_valid
  end
end
