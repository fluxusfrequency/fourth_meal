class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id
  belongs_to :address

  def pay!
    order.status = "paid"
    order.save
  end

  def user_transaction_email_data(transaction, link)
    { :email => transaction.address.email,
      :customer_name => transaction.address.first_name + " " + transaction.address.last_name,
      :restaurant_name => transaction.order.restaurant_name,
      :invoice_price => transaction.total,
      :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
      :order_status => transaction.order.status
    }
  end

  def owner_transaction_email_data(transaction, link, owner)
    { :email => owner.email,
      :customer_name => transaction.address.first_name + " " + transaction.address.last_name,
      :restaurant_name => transaction.order.restaurant_name,
      :invoice_price => transaction.total,
      :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
      :order_status => transaction.order.status
    }
  end

  def total
    @total ||= order.total_price
  end
end
