class ItemsController < ApplicationController
  before_action :load_category, :only => [:index, :in_category]
  layout "application"

  def load_category
    @categories = Category.all
  end

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    @items = @restaurant.items.active
    @page_title = "Full Menu"
  end

  def in_category
    @restaurant = Restaurant.find_by_slug(params[:restaurant])
    # @category = @restaurant.categories.find_by_slug(params[:category_slug])
    @items = @category.items.active
    @page_title = @category.title
    render :index
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash.notice = "#{@item.name} was updated"
    redirect_to edit_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :photo, :photo_file_name)
  end

  def load_category
    @categories = Category.all
  end

end


