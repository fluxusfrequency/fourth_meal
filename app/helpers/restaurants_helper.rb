module RestaurantsHelper
  def current_restaurant
    @current_restaurant = Restaurant.find_by_slug(session[:current_restaurant]) || Restaurant.find_by_slug(params[:restaurant_slug])
    session[:current_restaurant] = @current_restaurant.to_param
    @current_restaurant
  end

  def check_active
    @restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    fail_with_message
  end

  def fail_with_message
    if @restaurant && @restaurant.approved? && @restaurant.inactive?
      redirect_to root_path, :notice => "Sorry, this restaurant is currently offline for maintenance."
    elsif @restaurant && !@restaurant.approved?
      redirect_to root_path, :notice => "Sorry, we couldn't find the restaurant you requested in our sytem."
    end
  end

end


