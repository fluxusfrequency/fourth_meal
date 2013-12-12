require './test/test_helper'

class UserCheckoutTest < Capybara::Rails::TestCase

  def test_user_can_checkout_after_signing_up
    visit root_path
    click_on "KFC"
    


    visit root_path
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    click_on "Checkout"

    assert_content page, "Sign Up"
    assert_content page, "Log In"
    assert_content page, "Checkout As A Guest"

    within "#new_user" do
      fill_in "Email", with: 'benji@example.com'
      fill_in "Full name", with: 'Benjamin Franklin'
      fill_in "Display name", with: 'benitobeans'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_button "Create User"
    end

    assert_content page, "Logged in"
    assert_content page, "Enter a new address"
    refute_css page, ".address-panel"

    fill_in "First name", with: "Benji"
    fill_in "Last name", with: "Lewis"
    fill_in "Street address", with: "123 Main St."
    fill_in "City", with: "Your Town"
    fill_in "State", with: "HI"
    fill_in "Zipcode", with: 22884
    fill_in "Email", with: "Benji@yeehaw.com"
    click_on "Use This Billing Address"

    assert_content page, "Your address was successfully added."
    within ".address-panel" do
      click_on "Use This Billing Address"
    end

    assert_content page, "Transaction Information"

  end

  def test_user_can_checkout_after_signing_in
    visit root_path
    click_on "KFC"

    click_on "Sign up or Log in" 
    
    within "#new_user" do
      fill_in "Email", with: 'benji@example.com'
      fill_in "Full name", with: 'Benjamin Franklin'
      fill_in "Display name", with: 'benitobeans'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_button "Create User"
    end

    click_on "Log out"


    visit root_path
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    click_on "Checkout"

    assert_content page, "Sign Up"
    assert_content page, "Log In"
    assert_content page, "Checkout As A Guest"

    within "#login-form" do
      fill_in "Email", with: 'benji@example.com'
      fill_in "Password", with: 'password'
      click_button "Log In"
    end

    assert_content page, "Logged in"
    assert_content page, "Enter a new address"
    refute_css page, ".address-panel"

    fill_in "First name", with: "Benji"
    fill_in "Last name", with: "Lewis"
    fill_in "Street address", with: "123 Main St."
    fill_in "City", with: "Your Town"
    fill_in "State", with: "HI"
    fill_in "Zipcode", with: 22884
    fill_in "Email", with: "Benji@yeehaw.com"
    click_on "Use This Billing Address"

    assert_content page, "Your address was successfully added."
    within ".address-panel" do
      click_on "Use This Billing Address"
    end

    assert_content page, "Transaction Information"

    # TODO: Get Javascript testing working
    # click_on ".stripe-button-el"

  end

end

