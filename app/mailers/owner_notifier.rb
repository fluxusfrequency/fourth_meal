class OwnerNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "customer_service@noshify.com"

  def owner_approve_email(owner_email, link, restaurant)
    @email = owner_email
    @link = link
    @restaurant = restaurant
    mail(to: @email,
      subject: "Your restaurant, #{@restaurant.name}, has been approved!")
  end

  def owner_reject_email(owner_email, link, restaurant)
    @email = owner_email
    @link = link
    @restaurant = restaurant
    mail(to: @email,
      subject: "We're sorry, but your restaurant,
      #{@restaurant.name}, has been rejected.")
  end

end
