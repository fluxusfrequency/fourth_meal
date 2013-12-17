class Admin::DashboardController < ApplicationController
  before_action :ensure_user
  before_action :owner_access
  layout 'admin'

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    @themes = Restaurant.themes
    @locations = Location.all.collect {|location| location.city}.sort
  end

  def total_sales
    completed_orders = current_restaurant.orders.where(:status => 'complete')
    completed_orders.collect do |order|
      order.total_price
    end.reduce(:+)
  end

end
