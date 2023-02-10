class AddCartIdToShoppingCart < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_carts, :cart_id, :string
    add_index :shopping_carts, [:cart_id], unique: true
  end
end
