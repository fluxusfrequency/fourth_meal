class TransactionNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  def user_email(email, transaction, link)
    @email = email
    @transaction = transaction
    @address = Address.find(@transaction.address_id)
    @total = order_total(@transaction.order.order_items)
    @link = link
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @email,
      subject: "Order Confirmation for #{@restaurant.name} on Noshify!")
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end
