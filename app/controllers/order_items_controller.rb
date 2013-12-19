class OrderItemsController < ApplicationController
  before_action :check_active

  def destroy
    OrderItem.find(params[:id]).destroy
    flash[:notice] = "The item was removed from your cart."
    redirect_to order_path(session[:current_restaurant], current_order.id)
  end


end