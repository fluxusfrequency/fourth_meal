class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id

  def pay!
    order.status = "paid"
    order.save
  end

  def self.send_owner_transaction_email(address, owner, transaction, link)
    TransactionNotifier.owner_email(owner_transaction_email_data(address, owner, transaction, link)).deliver
  end

  def self.send_user_transaction_email(address, transaction, link)
    TransactionNotifier.user_email(user_transaction_email_data(address, transaction, link)).deliver
  end

  def user_transaction_email_data(address, transaction, link)
    { :email => address.email,
      :customer_name => address.first_name + " " + address.last_name,
      :restaurant_name => Restaurant.find(transaction.order.restaurant_id).name,
      :invoice_price => transaction.total,
      :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
      :order_status => transaction.order.status,
      :order_items => transaction.order_items.collect |oi|
                        [[oi.title], [oi.quantity]]
                      end 
    }
  end

  def owner_transaction_email_data(address, owner, transaction, link)
    { :email => owner.email,
      :customer_name => address.first_name + " " + address.last_name,
      :restaurant_name => Restaurant.find(transaction.order.restaurant_id).name,
      :invoice_price => transaction.total,
      :order_date_time => transaction.created_at.strftime("%b %d, %Y at %I:%M%p"),
      :order_status => transaction.order.status,
      :order_items => transaction.order_items.collect |oi|
                        [[oi.title], [oi.quantity]]
                      end 
    }
  end

  def total
    @total ||= order.total_price
  end
end
