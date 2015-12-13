require 'rails_helper'

describe BasicProject, :type => :model do
  it 'has a valid factory' do
    expect(create(:basic_project)).to be_valid
  end
end
