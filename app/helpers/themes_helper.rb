module ThemesHelper

  def current_theme
    if params[:restuarant_slug].nil?
      "application"
    elsif current_restaurant
      current_restaurant.theme
    else
      "application"
    end
  end

end