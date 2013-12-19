class Admin::DashboardController < ApplicationController
  before_action :ensure_user
  before_action :owner_access
  layout 'admin'

  def index
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    @themes = Restaurant.themes
    @locations = Location.all.collect {|location| location.city}.sort
  end

end
