class OwnerTransactionNotifierJob
  @queue = :emails

  def self.perform(customer_name, email, link, restaurant_name, order_date_time, invoice_price, order_status)
    TransactionNotifier.owner_email(
      customer_name,
      email,
      link,
      restaurant_name,
      order_date_time,
      invoice_price,
      order_status).deliver
  end
end