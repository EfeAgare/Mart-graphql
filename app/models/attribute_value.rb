## Create attribute_value table (stores values such as Yellow or XXL)
class AttributeValue < ApplicationRecord
  belongs_to :attri, foreign_key: "attribute_id", class_name: "Attribute"

  validates :value, presence: true
end
