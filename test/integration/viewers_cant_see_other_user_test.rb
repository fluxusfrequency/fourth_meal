require './test/test_helper'


class ViewersCantSeeOtherUserTest < Capybara::Rails::TestCase

  test "logged in user cannot view other user's info" do
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

    visit user_path(users(:two))
    refute_content page, 'breebird'
  end

  test "logged in user cannot create items" do
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

    visit new_admin_item_path(restaurants(:one))
    refute_content page, "Create an Item"
  end
end
