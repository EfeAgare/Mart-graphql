class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name,  null: false
      t.string :description
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
