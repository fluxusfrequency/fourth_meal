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
    if @restaurant.save
      @restaurant.restaurant_users.create(:restaurant => @restaurant,
                                          :user => current_user,
                                          :role => "owner")
      @location = Location.find_by_city(params[:restaurant][:location])
      @restaurant.update(location_id: @location.id)

      flash.notice = "Your request has been submitted.
                      You will be emailed when your restaurant is approved."
      session[:current_restaurant] = @restaurant.to_param
      notify_super_of_request(@restaurant)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def notify_super_of_request(restaurant)
    @restaurant = restaurant
    @link = root_url + superman_approval_path
    User.where(:super => true).each do |superman|
      Restaurant.send_super_email(
        current_user, superman.email, @link, @restaurant)
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
