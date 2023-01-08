require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:review) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:created_on) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
