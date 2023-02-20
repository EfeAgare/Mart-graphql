class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :product_name, presence: true
  validates :unit_cost, presence: true

  scope :fetch, -> (order_id) {find_by_sql(["SELECT id, order_id, product_id, attributes, product_name,
         quantity, unit_cost, (quantity * unit_cost) AS subtotal FROM   order_details 
         WHERE  order_id = ?", order_id])}

  scope :create_order, -> (order_id, cart_id) {
    ActiveRecord::Base.connection.exec_query("INSERT INTO order_details(order_id, product_id, 
        attributes, product_name, quantity, unit_cost, created_at, updated_at)
        SELECT $1, sc.product_id, sc.attributes, p.name, sc.quantity,
        COALESCE(NULLIF(p.discounted_price, 0), p.price) AS unit_cost, $2, $3
        FROM shopping_carts sc INNER JOIN products p ON p.id = sc.product_id
        WHERE sc.cart_id = $4 AND sc.buy_now = true", "SQL", [[nil, order_id], [nil, DateTime.now],
        [nil, DateTime.now], [nil, cart_id]])
  }
  
  def self.instance_method_already_implemented?(method_name)
    return true if %w(frozen frozen?).include? method_name 
  end
end
