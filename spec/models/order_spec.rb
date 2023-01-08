require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:created_on) }
    it { should validate_presence_of(:total_amount) }
  end

  describe 'associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:shipping) }
    it { should belong_to(:tax) }
  end
end
