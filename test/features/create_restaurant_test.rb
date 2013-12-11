require './test/test_helper'

class CreateRestaurantTest < Capybara::Rails::TestCase

  def test_user_can_create_restaurant
    visit root_path
    click_on "Sign up or Log in"

    within "#new_user" do
      fill_in "Email", with: 'benji@example.com'
      fill_in "Full name", with: 'Benjamin Franklin'
      fill_in "Display name", with: 'benitobeans'
      fill_in "Password", with: 'password'
      fill_in "Password confirmation", with: 'password'
      click_button "Create User"
    end
    assert_content page, 'Signed up!'

    # TODO: uncomment me when adam is done
    # click_on "Account Profile"
    # assert_content page, "Edit Your Account Info"

    click_on "Create A New Restaurant"

    assert_content page, "Creating A New Restaurant"

    fill_in "Name", with: "Jeff's Gelato"
    fill_in "Description", with: "Frozen Goodness"
    
    click_on "Submit Restaurant"

    assert_content page, "Your restaurant has been submitted and is pending review. We will email you when your restaurant is ready to go live."

  end

end

