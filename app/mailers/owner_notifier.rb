class OwnerNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "navyosu@gmail.com"

  def owner_approve_email(owner_email, link, restaurant_name, restaurant_description)
    @email = owner_email
    @link = link
    @restaurant_name = restaurant_name
    @restaurant_description = restaurant_description
    mail(to: @email,
      subject: "Your restaurant, #{restaurant_name}, has been approved!")
  end

  def owner_reject_email(owner_email, link, restaurant_name, restaurant_description)
    @email = owner_email
    @link = link
    @restaurant_name = restaurant_name
    @restaurant_description = restaurant_description
    mail(to: @email,
      subject: "We're sorry, but your restaurant, #{restaurant_name}, has been rejected.")
  end

end
