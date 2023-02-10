class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :product_name, presence: true
  validates :unit_cost, presence: true

  scope :fetch, -> (order_id) {find_by_sql(["SELECT order_id, product_id, attributes, product_name,
         quantity, unit_cost, (quantity * unit_cost) AS subtotal FROM   order_details 
         WHERE  order_id = ?", order_id])}

  scope :create_order, -> (id, cart_id) {
    find_by_sql(["INSERT INTO order_details 
        (?, product_id, attributes, product_name, quantity, unit_cost)
        SELECT ?, p.id, sc.attributes, p.name, sc.quantity,
        COALESCE(NULLIF(p.discounted_price, 0), p.price) AS unit_cost
        FROM shopping_carts sc INNER JOIN  products p ON sc.product_id = p.id
        WHERE  sc.cart_id = ? AND sc.buy_now", id, cart_id])
  }
  
  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
