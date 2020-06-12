class AddListingToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :listing, :integer
  end
end
