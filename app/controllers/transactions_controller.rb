class TransactionsController < ApplicationController
  before_action :check_active
  def new
    @transaction = Transaction.new
    session[:current_address] ||= params[:address_id]
    set_forwarding_path
    if current_user && session[:current_address]
      find_current_user_address
      render :new
    else
      find_redirect
    end
  end

  def add_guest_address
    @address = Address.create(address_params)
    if @address.save
      session[:current_address] = @address.id
      redirect_to guest_transaction_path(session[:current_restaurant])
    else
      flash.notice = "Your address failed to save"
      redirect_to :back
    end
  end

  def checkout_as_guest
    @transaction = Transaction.new
    current_or_new_guest_address
    render :new
  end

  def create
    create_transaction
    if @transaction.save
      process_saved_transaction
      flash[:notice] = "Successfully submitted your order!"
      redirect_to transaction_path(session[:current_restaurant], @transaction)
    else
      flash[:notice] = "There was a problem creating your order!"
      render :new
    end
  end

  def show
    @transaction = Transaction.find_by(id: params[:id])
    @address = Address.find(@transaction.address_id)
  end

  private

  def set_forwarding_path
    session[:forwarding_path] = addresses_path
  end

  def find_current_user_address
    @address = current_user.addresses.find_by_id(session[:current_address])
  end

  def find_redirect
    if current_user
      redirect_to addresses_path
    else
      flash[:checking_out] = true
      redirect_to new_session_path
    end
  end

  def current_or_new_guest_address
    if session[:current_address]
      @address = Address.find(session[:current_address])
    else
      @address = Address.new
    end
  end

  def create_transaction
    @transaction = Transaction.new(order_id: current_order.id,
                                   address_id: session[:current_address],
                                   stripe_token: params["stripeToken"])
  end

  def process_saved_transaction
    @transaction.pay!
    @address = Address.find(@transaction.address_id)
    @transaction.order.update(user_id: current_user.id) if current_user
    link = root_url +
      transaction_path(session[:current_restaurant], @transaction)[1..-1]

    send_owner_emails(@transaction, link)
    send_user_email(@transaction, link)

    clear_current_order
    clear_checkout_session_data
  end

  def transaction_params
    params.require(:transaction).permit(:stripe_token, :address, :stripe_email)
  end

  def send_owner_emails(transaction, link)
    current_restaurant.owners.each do |owner|
      Resque.enqueue(OwnerTransactionNotifierJob,
        transaction.address.first_name + " " + transaction.address.last_name,
        owner.email,
        link,
        current_restaurant.name,
        transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
        transaction.total,
        transaction.order.status)
    end
  end

  def send_user_email(transaction, link)
    Resque.enqueue(UserTransactionNotifierJob,
      transaction.address.first_name + " " + transaction.address.last_name,
      transaction.address.email,
      link,
      current_restaurant.name,
      transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
      transaction.total,
      transaction.order.status)
  end

  # def user_transaction_email_data(transaction, link)
  #   { :email => transaction.address.email,
  #     :customer_name => transaction.address.first_name + " " + transaction.address.last_name,
  #     :restaurant_name => transaction.order.restaurant_name,
  #     :invoice_price => transaction.total,
  #     :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
  #     :order_status => transaction.order.status,
  #     :link => link
  #   }
  # end

  # def owner_transaction_email_data(transaction, link, owner)
  #   { :email => owner.email,
  #     :customer_name => transaction.address.first_name + " " + transaction.address.last_name,
  #     :restaurant_name => transaction.order.restaurant_name,
  #     :invoice_price => transaction.total,
  #     :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
  #     :order_status => transaction.order.status,
  #     :link => link
  #   }
  # end

  def address_params
    params.require(:address).permit(
      :first_name,
      :last_name,
      :street_address,
      :city,
      :state,
      :zipcode,
      :email)
  end

  def clear_checkout_session_data
    session[:forwarding_path] = nil
    session[:current_address] = nil
  end

end
