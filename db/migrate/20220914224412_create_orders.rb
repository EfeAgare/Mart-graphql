class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :total_amount, null: false
      t.datetime :created_on, null: false
      t.datetime :shipped_on
      t.integer :status, default: 0
      t.string :comments
      t.references :customer, null: false, foreign_key: true
      t.string :auth_code
      t.string :reference
      t.references :shipping, null: false, foreign_key: true
      t.references :tax, null: false, foreign_key: true

      t.timestamps
    end
  end
end
