class AddCompletedToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :completed, :boolean
  end
end
