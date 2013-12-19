class SuperNotifierJob
  @queue = :emails

  def self.perform(customer_name, superman_email, link, restaurant_name, restaurant_description)
    SuperNotifier.super_email(customer_name, superman_email, link, restaurant_name, restaurant_description).deliver
  end
end