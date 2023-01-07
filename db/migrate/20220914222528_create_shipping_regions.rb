class CreateShippingRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_regions do |t|
      t.string :region, null: false

      t.timestamps
    end
  end
end
