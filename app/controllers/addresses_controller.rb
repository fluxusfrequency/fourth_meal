class AddressesController < ApplicationController
  before_action :check_active
  def index
    @addresses = current_user.addresses
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(address_params)
    if @address.save
      session[:current_address] = @address.id
      success_message
    else
      failure_message
    end
    find_redirect
  end

  def edit
    @address = current_user.addresses.find(params[:id])
  end

  def change
    session[:current_address] = nil
    redirect_to :back
  end

  private

  def find_redirect
    if current_user
      redirect_to addresses_path
    else
      redirect_to guest_transaction_path(session[:current_restaurant])
    end
  end

  def success_message
    flash.notice = "Your address was successfully added."
  end

  def failure_message
    flash.notice = "Errors prevented the address from being saved: #{@address.errors.full_messages}"
  end

  def address_params
    params.require(:address).permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :email)
  end

end
