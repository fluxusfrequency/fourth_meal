class LocationsController < ApplicationController
  layout "application"

  def index
    @locations = Location.all.sort
    @page_title = "Locations"
  end

  def show
    @location = Location.find(params[:id])
    @restaurants = @location.active_restaurants.order('random()').page(params[:page]).per(20)
  end
end
