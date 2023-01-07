class CreateAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :audits do |t|
      t.references :order, null: false, foreign_key: true
      t.datetime :created_on, null: false
      t.text :message, null: false
      t.integer :code, null: false

      t.timestamps
    end
  end
end
