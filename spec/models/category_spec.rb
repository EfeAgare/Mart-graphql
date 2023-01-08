require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:department) }
    it { should have_many(:product_category) }
  end
end
