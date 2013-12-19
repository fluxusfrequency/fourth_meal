class Superman::DashboardController < ApplicationController
  layout 'superman'
  before_action :ensure_user
  before_action :super_access

  def index
    @restaurants = Restaurant.not_rejected.page(params[:page]).per(20)
  end

end
