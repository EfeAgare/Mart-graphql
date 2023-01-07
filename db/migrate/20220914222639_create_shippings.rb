class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.references :shipping_region, null: false, foreign_key: true
      t.float :cost, null: false
      t.string :type, null: false

      t.timestamps
    end
  end
end
