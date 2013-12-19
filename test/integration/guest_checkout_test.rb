require './test/test_helper'

class GuestCheckoutTest < Capybara::Rails::TestCase

  def test_guest_can_checkout_without_signing_up
    visit root_path
    click_on "Denver"
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    click_on "Checkout"

    assert_content page, "Sign Up"
    assert_content page, "Log In"
    assert_content page, "Checkout As A Guest"

    within ".new_address" do
     fill_in "First name", with: "Benji"
     fill_in "Last name", with: "Lewis"
     fill_in "Street address", with: "123 Main St."
     fill_in "City", with: "Your Town"
     fill_in "State", with: "HI"
     fill_in "Zipcode", with: 22884
     fill_in "Email", with: "Benji@yeehaw.com"
     click_on "Use This Billing Address"
    end

    assert_content page, "Order Summary"
    assert_content page, "Checking out as Guest"

  end
end
