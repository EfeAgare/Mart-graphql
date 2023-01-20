require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:review) }
    it { should validate_presence_of(:rating) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:customer) }
  end
end
