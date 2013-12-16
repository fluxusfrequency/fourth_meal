class OwnerNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  def owner_email(owner, link, restaurant)
    @owner = owner
    @email = owner.email
    @link = link
    @restaurant = restaurant
    mail(to: @email, subject: "Your restaurant, #{@restaurant.name}, has been approved!")
  end

end
