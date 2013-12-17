class TransactionNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "customer_service@noshify.com"

  def user_email(email, transaction, link)
    @customer_name = transaction.order.user.full_name
    @email = email
    @transaction = transaction
    @link = link
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @email, subject: "Order Confirmation for #{@restaurant.name} on Noshify!")
  end

  def owner_email(email, transaction, link)
    @customer_name = transaction.order.user.full_name
    @email = email
    @transaction = transaction
    @link = link
    @restaurant = Restaurant.find(@transaction.order.restaurant_id)
    mail(to: @email, subject: "Order Received for #{@restaurant.name} on Noshify!")
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end
