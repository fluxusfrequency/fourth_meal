class Superman::RestaurantsController < ApplicationController
  layout 'superman'
  before_action :ensure_user
  before_action :super_access

  def index
    @restaurants = Restaurant.where(:status => "pending")
  end

  def rejected
    @restaurants = Restaurant.where(:status => "rejected")
  end

  def destroy
    @restaurant = Restaurant.find_by_slug(params[:id])
    @restaurant.toggle_status
    toggle_status_message
    redirect_to superman_path
  end

  def approve
    @restaurant = Restaurant.find_by_slug(params[:format])
    @restaurant.approve
    notify_owner_of_approval(@restaurant)
    redirect_to superman_path, :notice => "#{@restaurant.name} was approved!"
  end

  def reject
    @restaurant = Restaurant.find_by_slug(params[:format])
    @restaurant.reject
    notify_owner_of_rejection(@restaurant)
    redirect_to superman_path, :notice => "#{@restaurant.name} was rejected!"
  end

  private

  def toggle_status_message
    @restaurant.active ? activate_message : deactivate_message
  end

  def deactivate_message
    flash.notice = "#{@restaurant.name} was taken offline!"
  end

  def activate_message
    flash.notice = "#{@restaurant.name} was reactivated!"
  end

  def notify_owner_of_approval(restaurant)
    @owner = restaurant.owners.last
    @link = root_url + restaurant.slug + "/admin"
    @restaurant = restaurant
    OwnerNotifier.owner_approve_email(@owner, @link, @restaurant).deliver
  end

  def notify_owner_of_rejection(restaurant)
    @owner = restaurant.owners.last
    @link = root_url
    @restaurant = restaurant
    OwnerNotifier.owner_reject_email(@owner, @link, @restaurant).deliver
  end

end
