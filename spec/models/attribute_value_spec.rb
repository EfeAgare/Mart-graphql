require 'rails_helper'

RSpec.describe AttributeValue, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:value) }
  end

  describe 'associations' do
    it { should belong_to(:attri) }
  end
end
