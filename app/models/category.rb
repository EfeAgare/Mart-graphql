class Category < ApplicationRecord
  belongs_to :department
  has_many :product_category


  validates :name, presence: true
  validates :description, presence: true
end
