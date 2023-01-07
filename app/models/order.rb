class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :shipping
  belongs_to :tax
end
