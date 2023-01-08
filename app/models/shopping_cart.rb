class ShoppingCart < ApplicationRecord
  belongs_to :product

  validates :attributes, presence: true
  validates :quantity, presence: true
  validates :buy_now, presence: true
  validates :added_on, presence: true


  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
