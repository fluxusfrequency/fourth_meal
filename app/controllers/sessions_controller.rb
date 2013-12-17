class SessionsController < ApplicationController

  def new
    @user = User.new
    @address = Address.new unless session[:current_address]
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user
      session[:user_id] = @user.id
      flash[:notice] = "Logged in!"
      find_redirect
    else
      invalid_login_redirect
    end
  end

  def checkout_as_guest
    @transaction = Transaction.new
    if session[:current_address]
      @address = Address.find(session[:current_address])
    else
      @address = Address.new
    end
    render :new
  end

  def destroy
    session[:forwarding_path] = nil
    clear_current_order if session[:current_order]
    session[:current_restaurant] = nil
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  def find_redirect
    if session[:forwarding_path]
      redirect_to session[:forwarding_path]
    elsif current_restaurant
      redirect_to restaurant_root_path(session[:current_restaurant])
    else
      redirect_to root_path
    end
  end

  def invalid_login_redirect
    flash[:notice] = "Invalid email or password."
    redirect_to log_in_path
  end

end
