require 'rails_helper'

RSpec.describe Department, type: :model do
   describe "Validation" do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:categories) }
  end
end
