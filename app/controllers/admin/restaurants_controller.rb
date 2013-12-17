class Admin::RestaurantsController < ApplicationController
  before_action :owner_access
  layout 'admin'

  def show
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    redirect_to admin_path(session[:current_restaurant])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    @location = Location.find_by_city(params[:restaurant][:location])
    @restaurant.update(location_id: @location.id)
    session[:current_restaurant] = @restaurant.to_param
    redirect_to admin_path(session[:current_restaurant]),
      :notice => "#{@restaurant.name} was updated!"
  end

  def destroy
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    @restaurant.toggle_status
    toggle_status_message
    redirect_to admin_path(@restaurant)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug, :theme)
  end

  def toggle_status_message
    @restaurant.active ? activate_message : deactivate_message
  end

  def deactivate_message
    flash.notice = "#{@restaurant.name} was taken offline!"
  end

  def activate_message
    flash.notice = "#{@restaurant.name} was activated!"
  end

end
