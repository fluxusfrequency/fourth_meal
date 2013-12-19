require "test_helper"

class SuperNotifierTest < ActionMailer::TestCase
  tests SuperNotifier
  test "notifies supers of pending restaurant approval" do
    email = SuperNotifier.super_email(
      "Marvin Jarvis",
      "ben@example.com",
      "http://www.google.com/supernotifier",
      "Ono Burritoz",
      "Delicious Burritoz").deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal ["navyosu@gmail.com"], email.from
    assert_equal ["ben@example.com"], email.to
    assert_equal "New Restaurant Ono Burritoz on Noshify Pending Approval!", email.subject
  end

end
