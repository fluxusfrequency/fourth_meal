require './test/test_helper'

class UsersDoNotShareShoppingCartsTest < Capybara::Rails::TestCase

  def test_cart_is_not_shared_by_users
    visit root_path

    user1 = users(:one)
    user2 = User.create!(email: "rolen@example.com", full_name: "Rolen", display_name: "Roro", password: "password", password_confirmation: "password", super: false)

    click_on "Sign up or Log in"

    within "#login-form" do
      fill_in "Email", with: user1.email
      fill_in "Password", with: "password"
      click_on "Log In"
    end

    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"

    assert_content page,("Mashed Potatoes")

    click_on "Log out"

    assert current_path == root_path

    refute_content page, "Log out"

    assert_content page, "Sign up or Log in"
    click_on "Sign up or Log in"

    assert_equal "rolen@example.com", user2.email

    within "#login-form" do
      fill_in "Email", with: "rolen@example.com"
      fill_in "Password", with: "password"
      click_on "Log In"
    end

    click_on "KFC"
    
    save_and_open_page

    refute_content page, "View Your Order"

  end
end
