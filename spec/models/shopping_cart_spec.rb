require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:attributes) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:buy_now) }
    it { should validate_presence_of(:added_on) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
