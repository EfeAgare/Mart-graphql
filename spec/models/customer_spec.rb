require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:name) }
  end
end
