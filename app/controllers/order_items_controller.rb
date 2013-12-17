class OrderItemsController < ApplicationController
  before_action :check_active
  def destroy
    OrderItem.find(params[:id]).destroy
    if current_order.items_in_cart?
      success_message
    else
      cancel_order_message
    end
    redirect_to order_path(session[:current_restaurant], current_order.id)
  end

  private

  def success_message
    flash[:notice] = "The item was removed from your cart."
  end

  def cancel_order_message
    flash[:notice] = "Your order has been cancelled."
  end
  
end