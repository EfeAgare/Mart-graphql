class ShoppingCart < ApplicationRecord
  belongs_to :product

  validates :attributes, presence: true
  validates :quantity, presence: true
  validates :added_on, presence: true

  scope :fetch_total_amount, -> (cart_id) {
    find_by_sql([
         "SELECT SUM(COALESCE(NULLIF(p.discounted_price, 0), p.price) * sc.quantity) AS total_amount
            FROM shopping_carts sc INNER JOIN products p ON sc.product_id = p.id
            WHERE sc.cart_id = ? AND sc.buy_now", cart_id])
  }
  
  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
