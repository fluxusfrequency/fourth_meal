class AddThemeToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :theme, :string, default: "application"
  end
end
