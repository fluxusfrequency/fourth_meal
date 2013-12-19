module ThemesHelper

  def current_theme
    if current_restaurant && current_path != root_path
      current_restaurant.theme
    else
      "application"
    end
  end

end