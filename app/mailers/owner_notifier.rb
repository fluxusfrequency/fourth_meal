class OwnerNotifier < ActionMailer::Base
  default from: "customer_service@noshify.com"

  def owner_email(user, superman, link, restaurant)
    @user = user
    @email = superman.email
    @link = link
    @restaurant = restaurant
    mail(to: @email, subject: "New Restaurant #{@restaurant.name} on Noshify Pending Approval!")
  end

end
