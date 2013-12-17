class Admin::ItemsController < ApplicationController
  before_action :owner_access
  layout 'admin'

  def index
    @items = current_restaurant.items.sort
  end

  def destroy
    @item = current_restaurant.items.find(params[:id])
    @item.toggle_status
    toggle_status_message
    redirect_to admin_items_path(session[:current_restaurant])
  end

  def create
    @item = current_restaurant.items.build(admin_item_params)
    if @item.save
      @category = Category.find_by_title(params[:item][:categories])
      ItemCategory.create(item_id: @item.id, category_id: @category.id)
      flash.notice = "#{@item.title} was added to the menu!"
    else
      flash.notice = "Errors prevented the item from being created: #{@item.errors.full_messages}"
    end
    redirect_to admin_items_path(session[:current_restaurant])
  end

  def new
    @item = current_restaurant.items.build
    @categories = current_restaurant.categories.collect {|c| c.title}
  end

  def edit
    @item = current_restaurant.items.find(params[:id])
  end

  def update
    @item = current_restaurant.items.find(params[:id])
    @item.update(admin_item_params)
    if @item.save
      flash.notice = "#{@item.title} was updated"
    else
      flash.notice = "Errors prevented the item from being edited: #{@item.errors.full_messages}"
    end
    redirect_to admin_items_path(session[:current_restaurant])
  end

  private

  def toggle_status_message
    @item.retired ? retire_message : activate_message
  end

  def retire_message
    flash.notice = "#{@item.title} was retired from the menu!"
  end

  def activate_message
    flash.notice = "#{@item.title} was added to the menu!"
  end

  def admin_item_params
    params.require(:item).permit(:title, :description, :price, :retired)
  end

end
