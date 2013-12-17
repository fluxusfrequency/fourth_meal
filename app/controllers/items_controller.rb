class ItemsController < ApplicationController
  layout "application"
  before_action :check_active,
                :load_restaurant,
                :load_category, only: [:in_category, :index]

  def in_category
    @category = @restaurant.categories.find_by_slug(params[:category_slug])
    @items = @category.items.active
    @page_title = @category.title
    render :index
  end

  def index
    @items = @restaurant.items.active
    @page_title = "Full Menu"
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    session[:current_restaurant] = @restaurant.to_param
  end

  def load_category
    @categories = current_restaurant.categories
  end

  def item_params
    params.require(:item).permit(
      :title,
      :description,
      :price,
      :photo,
      :photo_file_name)
  end

end


