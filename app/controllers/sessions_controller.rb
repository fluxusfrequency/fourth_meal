class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Logged in!"
      if session[:forwarding_path]
        redirect_to session[:forwarding_path]
      elsif current_restaurant
        redirect_to restaurant_root_path(session[:current_restaurant])
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "Invalid email or password"
      redirect_to log_in_path
    end
  end

  def destroy
    session[:forward_path] = nil
    session[:current_order] = nil
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
