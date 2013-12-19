module ThemesHelper

  def current_theme
    if !params[:restuarant_slug]
      "application"
    elsif current_restaurant
      current_restaurant.theme
    else
      "application"
    end
  end

end