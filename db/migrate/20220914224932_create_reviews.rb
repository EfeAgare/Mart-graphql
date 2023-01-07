class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :customer
      t.references :product, null: false, foreign_key: true
      t.text :review, null: false
      t.integer :rating, null: false
      t.datetime :created_on, null: false

      t.timestamps
    end
  end
end
