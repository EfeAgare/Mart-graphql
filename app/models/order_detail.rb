class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :product_name, presence: true
  validates :unit_cost, presence: true

  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
