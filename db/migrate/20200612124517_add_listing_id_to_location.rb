class AddListingIdToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :listing_id, :integer
  end
end
