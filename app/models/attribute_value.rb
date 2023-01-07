## Create attribute_value table (stores values such as Yellow or XXL)
class AttributeValue < ApplicationRecord
  belongs_to :attribute

  validates :value, presence: true
end
