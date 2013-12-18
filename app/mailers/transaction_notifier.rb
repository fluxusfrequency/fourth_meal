class TransactionNotifier < ActionMailer::Base
  default from: "navyosu@gmail.com"

  def user_email(data)
    @customer_name = data[:customer_name]
    @email = data[:email]
    @link = data[:link]
    @restaurant_name = data[:restaurant_name]
    @order_date_time = data[:order_date_time]
    @invoice_price = data[:invoice_price]
    @order_status = data[:order_status]
    mail(to: data[:email],
      subject: "Order Confirmation for #{@restaurant_name} on Noshify!")
  end

  def owner_email(data)
    # @customer_name = data[:customer_name]
    # @email = data[:email]
    # @link = data[:link]
    # @restaurant_name = data[:restaurant_name]
    # @order_date_time = data[:order_date_time]
    # @invoice_price = data[:invoice_price]
    # @order_status = data[:order_status]
    mail(to: data,
      subject: "Order Received for @restaurant_name on Noshify!")
  end
o
  def order_total(order_items)
    order_items.inject(0) {|sum, i| sum += (i.item.price * i.quantity) }
  end

end
