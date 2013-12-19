require './test/test_helper'

class UserProfileTest < Capybara::Rails::TestCase

  test "user can make use of her profile page" do
    # user signs up
    visit root_path
    click_on "Sign up or Log in"

    within "#new_user" do
      fill_in "Email", with: 'benita@example.com'
      fill_in "Full name", with: 'Benita Franklin'
      fill_in "Display name", with: 'benitabeans'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_button "Create User"
    end
    assert_content page, 'Logged in'

    click_on "Account Profile"
    assert_content page, "Edit Your Account Info"
    assert_content page, "Your Addresses"



    # user changes her details
    fill_in "Email", with: "benita_2000@example.com"
    fill_in "Full name", with: "Benita Lynn Franklin"
    fill_in "Display name", with: "benita_2000"
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Update User"

    assert_content page, "Credentials updated!"


    # user adds an address
    click_on "Add New Address"
    fill_in "First name", with: "Benita"
    fill_in "Last name", with: "Franklin"
    fill_in "Street address", with: "123 Benita Street"
    fill_in "City", with: 'Denver'
    fill_in "State", with: 'CO'
    fill_in "Zipcode", with: '98765'
    fill_in "Email", with: "benita_2000@example.com"

    click_button "Use This Address"

    assert_content page, "Your address was successfully added."
    assert_equal user_path(User.last), current_path

    assert_content page, "123 Benita Street"

    # user edits an address
    click_on "Edit Address"
    assert_equal edit_address_path(Address.last.id), current_path

    fill_in "First name", with: "Benzita"
    fill_in "Last name", with: "Franks"
    fill_in "Street address", with: "123 Benita St"
    fill_in "City", with: 'Portland'
    fill_in "State", with: 'OR'
    fill_in "Zipcode", with: '98765'
    fill_in "Email", with: "benita_2000@example.com"
    click_on "Use This Address"

    assert_content page, "Your address was successfully updated!"

    # user deletes an address
    click_on "Delete"
    assert_content page, "Your address was successfully deleted!"
    refute_content page, "123 Benita St"
  end

end