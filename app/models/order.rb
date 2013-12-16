class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :status, presence: true, inclusion: { in: 
    ['unpaid', 'paid'] }

  has_many :order_items, inverse_of: :order
  has_many :items, through: :order_items
  has_one  :transaction

  def items_in_cart?
    self.order_items.count > 0
  end

  def total_price
    Rails.cache.fetch("order_total_price") do
      self.order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
    end
  end
end
