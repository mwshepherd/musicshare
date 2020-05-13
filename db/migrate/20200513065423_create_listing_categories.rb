class CreateListingCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :listing_categories do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
