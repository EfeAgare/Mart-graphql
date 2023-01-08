require 'rails_helper'

RSpec.describe ShippingRegion, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:region) }
  end
end
