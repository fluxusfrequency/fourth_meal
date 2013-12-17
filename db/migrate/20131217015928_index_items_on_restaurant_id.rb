class IndexItemsOnRestaurantId < ActiveRecord::Migration
  def change
    add_index :items, :restaurant_id
  end
end
