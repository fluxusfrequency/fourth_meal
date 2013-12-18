class TransactionNotifier < ActionMailer::Base
  default from: "navyosu@gmail.com"

  def user_email(customer_name, email, link, restaurant_name, order_date_time, invoice_price, order_status)
    @customer_name = customer_name
    @email = email
    @link = link
    @restaurant_name = restaurant_name
    @order_date_time = order_date_time
    @invoice_price = invoice_price
    @order_status = order_status
    mail(to: @email,
      subject: "Order Confirmation for #{@restaurant_name} on Noshify!")
  end

  def owner_email(customer_name, email, link, restaurant_name, order_date_time, invoice_price, order_status)
    @customer_name = customer_name
    @email = email
    @link = link
    @restaurant_name = restaurant_name
    @order_date_time = order_date_time
    @invoice_price = invoice_price
    @order_status = order_status
    mail(to: @email,
      subject: "Order Received for #{@restaurant_name} on Noshify!")
  end

  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end
