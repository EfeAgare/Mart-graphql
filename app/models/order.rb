class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :shipping
  belongs_to :tax

  has_many :order_details

  validates :total_amount, presence: true

  enum status: {
    pending_confirmation: 0,
    confirmed: 1,
    shipped: 2,
    paid: 3,
    delivered: 4
  }

  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
