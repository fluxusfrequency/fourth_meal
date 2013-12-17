class IndexItemCategoriesOnItemId < ActiveRecord::Migration
  def change
    add_index :item_categories, :item_id
  end
end
