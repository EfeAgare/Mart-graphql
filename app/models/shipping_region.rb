class ShippingRegion < ApplicationRecord
  validates :region, presence: true

  has_many :customer
end
