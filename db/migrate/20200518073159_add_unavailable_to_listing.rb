class AddUnavailableToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :unavailable, :boolean
  end
end
