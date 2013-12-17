class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if current_restaurant && @user.save
      session[:user_id] = @user.id
      current_order.update(user: @user) if current_order
      find_redirect
    elsif @user.save
      session[:user_id] = @user.id
      flash.notice = "Signed up!"
      redirect_to root_path
    else
      flash.notice = "There were errors that prevented your account from saving: #{@user.errors.full_messages}"
      redirect_to log_in_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), :notice => "Credentials updated!"
    else
      redirect_to user_path(@user.id), :notice => "Your account was not saved for some reason!"
    end
  end

  def show
    @user = current_user
    @addresses = current_user.addresses
  end



private

  def find_redirect
    if session[:forwarding_path]
      redirect_to session[:forwarding_path]
    elsif session[:current_restaurant]
      redirect_to restaurant_root_path(session[:current_restaurant]), :notice => "Signed up!"
    else
      redirect_to root_path, :notice => "Signed up!"
    end
  end
    
  def set_user
    @user = user.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation)
  end
end
