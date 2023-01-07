class CreateShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.references :product, null: false, foreign_key: true
      t.string :attributes, null: false
      t.integer :quantity, null: false
      t.boolean :buy_now, null: false, default: true
      t.datetime :added_on, null: false

      t.timestamps
    end
  end
end
