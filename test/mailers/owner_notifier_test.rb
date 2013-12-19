require "test_helper"

class OwnerNotifierTest < ActionMailer::TestCase
  tests OwnerNotifier
  test "notifies owner of restaurant approval" do
    email = OwnerNotifier.owner_approve_email(
      "ben@example.com",
      "http://www.google.com",
      "Ono Burrito",
      "Delicious Burritos").deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal ["navyosu@gmail.com"], email.from
    assert_equal ["ben@example.com"], email.to
    assert_equal "Your restaurant, Ono Burrito, has been approved!", email.subject
  end

  test "notifies owner of restaurant rejection" do
    email = OwnerNotifier.owner_reject_email(
      "darryl@example.com",
      "http://www.google.com",
      "Darryl's Roadkill",
      "Delicious Armadillos").deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal ["navyosu@gmail.com"], email.from
    assert_equal ["darryl@example.com"], email.to
    assert_equal "We're sorry, but your restaurant, Darryl's Roadkill, has been rejected.", email.subject
  end
end
