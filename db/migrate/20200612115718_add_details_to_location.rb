class AddDetailsToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :longitude, :float
    add_column :locations, :latitude, :float
  end
end
