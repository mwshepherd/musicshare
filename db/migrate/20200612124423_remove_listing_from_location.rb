class RemoveListingFromLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :listing, :integer
  end
end
