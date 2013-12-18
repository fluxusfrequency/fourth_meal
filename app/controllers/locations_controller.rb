class LocationsController < ApplicationController
  def index
    @locations = Location.all.sort
    @page_title = "Locations"
  end

  def show
    @location = Location.find(params[:id])
    @restaurants = @location.active_restaurants.page(params[:page]).per(20)
  end
end
