class IndexRestaurantsUsersOnUserId < ActiveRecord::Migration
  def change
    add_index :restaurant_users, :user_id
  end
end
