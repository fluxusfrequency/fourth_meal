class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && current_order.id
      session[:user_id] = @user.id
      current_order.update_attributes(:user_id => @user.id) # new line
      current_order.save
      redirect_to order_path(current_order.id), :notice => "Signed up!"
    elsif @user.save && !current_order.id
      session[:user_id] = @user.id
      redirect_to menu_path
    else
      render "sessions/new"
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
  end

  def is_admin?
    current_user && current_user.admin
  end

private

  def set_user
    @user = user.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation, :admin)
  end
end
