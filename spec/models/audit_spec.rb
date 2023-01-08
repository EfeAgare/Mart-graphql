require 'rails_helper'

RSpec.describe Audit, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:code) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
  end
end
