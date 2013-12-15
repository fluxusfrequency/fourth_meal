class RestaurantsController < ApplicationController
  layout 'home'
  def index
    @locations ||= Location.all.includes(:restaurants)
  end

  def new
    verify_logged_in_user
    @restaurant = Restaurant.new
  end

  def create
    verify_logged_in_user
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save

      @restaurant.restaurant_users.create(:restaurant => @restaurant, 
                                          :user => current_user, 
                                          :role => "owner")

      flash.notice = "Your request has been submitted. 
                      You will be emailed when your restaurant is approved."

      notify_super_of_request
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def notify_super_of_request
    @superman = User.where(:super => true).first
    @link = root_url + superman_approval_path
    SuperNotifier.super_email(current_user, @superman, @link, @restaurant).deliver
  end

  def verify_logged_in_user
    unless current_user
      redirect_to log_in_path
      flash.notice = "Please login before attempting to create a new restaurant."
    end
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
