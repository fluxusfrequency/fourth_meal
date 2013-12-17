class AddIndexOnLocationIdToRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurants, :location_id
  end
end
