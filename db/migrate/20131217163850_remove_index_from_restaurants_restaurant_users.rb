class RemoveIndexFromRestaurantsRestaurantUsers < ActiveRecord::Migration
  def change
    remove_index :restaurant_users, :restaurant_id
  end
end
