class CreateTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :taxes do |t|
      t.string :type, null: false
      t.float :percentage, null: false

      t.timestamps
    end
  end
end
