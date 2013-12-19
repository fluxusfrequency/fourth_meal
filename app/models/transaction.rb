class Transaction < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order_id
  belongs_to :address

  def pay!
    order.status = "paid"
    order.save
  end

  def total
    @total ||= order.total_price
  end
end
