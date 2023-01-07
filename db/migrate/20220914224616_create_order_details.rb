class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order, null: false, foreign_key: true
      t.string :attributes, null: false
      t.integer :quantity, null: false
      t.string :product_name, null: false
      t.decimal :unit_cost, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
