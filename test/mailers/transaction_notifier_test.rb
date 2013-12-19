require "test_helper"

class TransactionNotifierTest < ActionMailer::TestCase
  tests TransactionNotifier
  test "notifies users of their orders" do
    email = TransactionNotifier.user_email(
      "Marla Jarvis",
      "benito@example.com",
      "http://www.google.com/supernotifier",
      "Ono Taco",
      Time.now.strftime("%b %d, %Y at %I:%M%p"),
      142,
      "paid").deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal ["navyosu@gmail.com"], email.from
    assert_equal ["benito@example.com"], email.to
    assert_equal "Order Confirmation for Ono Taco on Noshify!", email.subject
  end

  test "notifies owners of new orders" do
    email = TransactionNotifier.owner_email(
      "Marzipan Jarvis",
      "bennybeanies@example.com",
      "http://www.google.com/supernotifier2",
      "Ono Tacoz",
      Time.now.strftime("%b %d, %Y at %I:%M%p"),
      12,
      "paid").deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal ["navyosu@gmail.com"], email.from
    assert_equal ["bennybeanies@example.com"], email.to
    assert_equal "Order Received for Ono Tacoz on Noshify!", email.subject
  end

end
