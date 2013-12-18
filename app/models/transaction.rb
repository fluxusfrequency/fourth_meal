class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id

  def pay!
    order.status = "paid"
    order.save
  end

  def self.send_owner_transaction_email(owner, transaction, link)
    TransactionNotifier.owner_email(owner.email, transaction, link).deliver
  end

  def self.send_user_transaction_email(address, transaction, link)
    TransactionNotifier.user_email(address.email, transaction, link).deliver
  end

  def total
    @total ||= order.total_price
  end
end
