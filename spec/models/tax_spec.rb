require 'rails_helper'

RSpec.describe Tax, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:percentage) }
  end
end
