require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
   describe "Validation" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:unit_cost) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end
end
