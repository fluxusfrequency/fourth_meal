class IndexItemCategoriesOnCategoryId < ActiveRecord::Migration
  def change
    add_index :item_categories, :category_id
  end
end
