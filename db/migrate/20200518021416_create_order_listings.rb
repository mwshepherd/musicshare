class CreateOrderListings < ActiveRecord::Migration[6.0]
  def change
    create_table :order_listings do |t|
      t.references :order, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
