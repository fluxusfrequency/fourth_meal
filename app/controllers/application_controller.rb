class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include AuthHelper
  include ApplicationHelper
  include OrdersHelper
  include UsersHelper
  include RestaurantsHelper
  include ThemesHelper

  helper_method :current_user, :current_order, :current_order_total,
                :items_in_cart?, :order_total, :check_active, :unauthorized,
                :current_theme, :current_restaurant, :is_admin?, :current_theme
end
