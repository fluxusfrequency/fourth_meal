class SuperNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "customer_service@noshify.com"

  def super_email(user, superman_email, link, restaurant)
    @user = user
    @email = superman_email
    @link = link
    @restaurant = restaurant
    mail(to: @email,
      subject: "New Restaurant #{@restaurant.name}
      on Noshify Pending Approval!")
  end

end
