require 'rails_helper'

RSpec.describe ProductAttribute, type: :model do

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:attribute_value) }
  end
end
