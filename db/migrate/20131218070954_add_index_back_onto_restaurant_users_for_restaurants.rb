class AddIndexBackOntoRestaurantUsersForRestaurants < ActiveRecord::Migration
  def change
    add_index :restaurant_users, :restaurant_id
  end
end
