module RestaurantsHelper
  def current_restaurant
    current_restaurant = Restaurant.find_by_slug(
      session[:current_restaurant]) ||
      Restaurant.find_by_slug(params[:restaurant_slug])
    session[:current_restaurant] = current_restaurant.to_param
    current_restaurant
  end

  def check_active
    restaurant = Restaurant.find_by_slug(params[:restaurant_slug])
    if restaurant
      offline_restaurant_failure if restaurant.offline?
      unapproved_restaurant_failure if restaurant.unapproved?
    end
  end

  private

  def offline_restaurant_failure
    if current_user && owner_access
      offline_admin_redirect
    else
      offline_redirect
    end
  end

  def unapproved_restaurant_failure
    unapproved_redirect
  end

  def offline_redirect
    redirect_to root_path,
      :notice => "Sorry, this restaurant is currently offline for maintenance."
  end

  def offline_admin_redirect
    redirect_to admin_path(@restaurant.slug),
      :notice => "Your restaurant is currently offline.
      Please click 'Activate' to make it active."
  end

  def unapproved_redirect
    redirect_to root_path,
      :notice => "Sorry, we couldn't find
      the restaurant you requested in our sytem."
  end

end


