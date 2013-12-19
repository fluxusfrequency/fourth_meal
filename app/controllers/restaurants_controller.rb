class RestaurantsController < ApplicationController
  layout 'home'

  def new
    verify_logged_in_user
    @restaurant = Restaurant.new
    @themes = Restaurant.themes
    @locations = Location.all.collect {|location| location.city}.sort
  end

  def create
    verify_logged_in_user
    @restaurant = Restaurant.new(restaurant_params)
    update_location
    if @restaurant.save
      process_saved_restaurant
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def process_saved_restaurant
    create_owner
    flash.notice = "Your request has been submitted.
                    You will be emailed when your restaurant is approved."
    session[:current_restaurant] = @restaurant.to_param
    notify_supers_of_request(@restaurant)
  end

  def update_location
    @location = Location.find_by_city(params[:restaurant][:location])
    @restaurant.update(location_id: @location.id)
  end

  def create_owner
    @restaurant.create_owner(current_user)
  end

  def notify_supers_of_request(restaurant)
    link = root_url + superman_approval_path[1..-1]

    User.superheroes.each do |superman|
      Resque.enqueue(SuperNotifierJob, current_user.full_name, superman.email, link, restaurant.name, restaurant.description)
    end
  end

  def verify_logged_in_user
    unless current_user
      redirect_to log_in_path
      flash.notice = "Please login before attempting
        to create a new restaurant."
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :slug, :theme)
  end

end
