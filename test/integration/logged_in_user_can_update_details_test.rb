require './test/test_helper'
class LoggedInUserCanUpdateDetailsTest < Capybara::Rails::TestCase

  def test_user_can_update_details
    user = users(:one)

    visit root_path

    click_on "Sign up or Log in"

    assert_equal "test@example.com", user.email

    within "#login-form" do
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "password"
      click_on "Log In"
    end

    click_on "Account Profile"

    assert_content page, "Edit Your Account Info"

    within ".edit_user" do
      fill_in "Email", with: "ben@example.com"
      fill_in "Full name", with: "Likes Cats"
      fill_in "Display name", with: "kittsy"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_on "Update User"
    end

    assert_content page, "Credentials updated!"
  end
end
