class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  delegate :allow?, to: :current_permission

  helper_method :allow?
  helper_method :current_user
  helper_method :current_order
  helper_method :current_order_total

  def current_order
    Order.find_by_id(session[:current_order]) || Order.new(status: "unpaid")
  end

  def categories
   @categories ||= Category.all
  end

  def current_order_total
    order_total(current_order.order_items)
  end

  private

   def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

   def current_permission
     @current_permission ||= Permission.new(current_user)
   end

end
