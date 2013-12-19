class Superman::RestaurantsController < ApplicationController
  layout 'superman'
  before_action :ensure_user
  before_action :super_access

  def index
    @restaurants = Restaurant.pending.page(params[:page]).per(20)
  end

  def inactive
    @restaurants = Restaurant.inactive.page(params[:page]).per(20)
  end

  def rejected
    @restaurants = Restaurant.rejected.page(params[:page]).per(20)
  end

  def destroy
    @restaurant = Restaurant.find_by_slug(params[:id])
    @restaurant.toggle_status
    toggle_status_message
    redirect_to superman_path
  end

  def approve
    restaurant = Restaurant.find_by_slug(params[:format])
    restaurant.approve
    notify_owners_of_approval(restaurant)
    redirect_to superman_path, :notice => "#{restaurant.name} was approved!"
  end

  def reject
    restaurant = Restaurant.find_by_slug(params[:format])
    restaurant.reject
    notify_owners_of_rejection(restaurant)
    redirect_to superman_path, :notice => "#{restaurant.name} was rejected!"
  end

  private

  def toggle_status_message
    @restaurant.active ? activate_message : deactivate_message
  end

  def deactivate_message
    flash.notice = "#{@restaurant.name} was taken offline!"
  end

  def activate_message
    flash.notice = "#{@restaurant.name} was activated!"
  end

  def notify_owners_of_approval(restaurant)
    link = root_url + restaurant.slug + "/admin"
    restaurant.owners.each do |owner|
      OwnerNotifier.owner_approve_email(owner.email, link, restaurant.name, restaurant.description).deliver
    end
  end

  def notify_owners_of_rejection(restaurant)
    link = root_url
    restaurant.owners.each do |owner|
      OwnerNotifier.owner_reject_email(owner.email, link, restaurant.name, restaurant.description).deliver
    end
  end

end
