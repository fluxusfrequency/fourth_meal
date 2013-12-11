class Admin::ItemsController < ApplicationController
  # before_action :can_access
  layout 'admin'

  def index
    @items = current_restaurant.items.sort
    authorize! :manage, @items
  end

  def destroy
    @item = current_restaurant.items.find(params[:id])
    authorize! :manage, @item
    @item.toggle_status
    toggle_status_message
    redirect_to admin_items_path(session[:current_restaurant])
  end

  def create
    @item = current_restaurant.items.build(admin_item_params)
    authorize! :manage, @item
    if @item.save
      flash.notice = "#{@item.title} was added to the menu!"
    else
      flash.notice = "Errors prevented the item from being created: #{@item.errors.full_messages}"
    end
    redirect_to admin_items_path(session[:current_restaurant])
  end

  def new
    @item = current_restaurant.items.build
    authorize! :manage, @item
  end

  def edit
    @item = current_restaurant.items.find(params[:id])
    authorize! :manage, @item
  end

  def update
    @item = current_restaurant.items.find(params[:id])
    authorize! :manage, @item
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
