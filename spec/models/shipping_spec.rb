require 'rails_helper'

RSpec.describe Shipping, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:cost) }
    it { should validate_presence_of(:type) }
  end

  describe 'associations' do
    it { should belong_to(:shipping_region) }
  end
end
