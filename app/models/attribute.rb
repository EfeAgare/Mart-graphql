##  Create attribute table (stores attributes such as Size and Color)
class Attribute < ApplicationRecord
  validates :name, presence: true
end
