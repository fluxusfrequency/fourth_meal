class SuperNotifier < ActionMailer::Base
  include Resque::Mailer
  default from: "customer_service@noshify.com"

  def super_email(customer_name, superman_email, link, restaurant_name, restaurant_description)
    @customer_name = customer_name
    @email = superman_email
    @link = link
    @restaurant_name = restaurant_name
    @restaurant_description = restaurant_description
    mail(to: @email,
      subject: "New Restaurant #{@restaurant_name}
      on Noshify Pending Approval!")
  end

end
