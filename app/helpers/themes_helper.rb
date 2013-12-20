module ThemesHelper

  def current_theme
    if current_restaurant
      current_restaurant.theme
    else
      "application"
    end
  end

end