class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name,  null: false
      t.string :description,  null: false
      t.decimal :price,  null: false
      t.decimal :discounted_price, null: false, default: 0.00
      t.string :image
      t.string :image_2
      t.string :thumbnail
      t.integer :display,  null: false, default: 0

      t.timestamps
    end
  end
end
