require 'rails_helper'

RSpec.describe Attribute, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:name) }
  end
end
