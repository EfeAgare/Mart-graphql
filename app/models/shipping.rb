class Shipping < ApplicationRecord
  belongs_to :shipping_region

  validates :cost, presence: true
  validates :type, presence: true

  self.inheritance_column = nil

end
