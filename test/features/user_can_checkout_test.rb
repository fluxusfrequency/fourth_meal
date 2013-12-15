require './test/test_helper'

class UserCanCheckoutTest < Capybara::Rails::TestCase

  def test_user_can_checkout_after_adding_items_clicking_on_checkout
    visit root_path
    user = users(:one)
    click_on "Sign up or Log in"

    assert_equal "test@example.com", user.email

    within "#login-form" do
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_on "Log In"
    end

    assert_content page, "Logged in!"

    click_on "KFC"

    within "#item_298486374" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"

    click_on "Checkout"

    refute current_path == root_path, "Does not redirect to root path after checkout"
  end
end
