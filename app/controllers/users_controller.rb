class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && current_order.id
      # current_user.move_to(@user) if is_admin?
      session[:user_id] = @user.id
      current_order.save
      redirect_to order_path(current_order.id), :notice => "Signed up!"
    elsif @user.save && !current_order.id
      session[:user_id] = @user.id
      redirect_to menu_path
    else
      render "new"
      redirect_to sign_up_path
    end
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