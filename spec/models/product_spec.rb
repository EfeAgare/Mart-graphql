require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:discounted_price) }
  end

  describe 'associations' do
    it { should have_many(:product_categories) }
    it { should have_many(:order_details) }
  end
end
