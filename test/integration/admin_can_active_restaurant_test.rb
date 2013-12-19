require './test/test_helper'

class AdminCanActiveRestaurantTest < Capybara::Rails::TestCase

  def test_user_can_create_a_restaurant

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
    assert_content page, 'Logged in'
    click_on "Create New Restaurant"

    assert_content page, "Creating A New Restaurant"

    fill_in "Name", with: "Pizza Hut"
    fill_in "Description", with: "Best Pizza House"
    fill_in "Slug", with: "pizza-hut"
    click_on "Create Restaurant"

    assert current_path == root_path, "redirected back to the restaurant root path"
    assert_content page, "Your request has been submitted. You will be emailed when your restaurant is approved."
  end

  def test_pending_restaurant_cannot_be_seen
    visit restaurant_root_path(restaurants(:four))
    assert_content page, "Sorry, we couldn't find the restaurant you requested in our sytem."
  end


  def test_approved_restaurant_can_be_seen_when_active
    visit root_path
    visit restaurant_root_path(restaurants(:seven))
    assert_content page, "Sorry, this restaurant is currently offline for maintenance."
  end

  def test_owner_can_activate_approved_restaurant

    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @res = Restaurant.create(name: "pizz", description: "cool", active: false, status: true, slug: "pizz")
    @ru = RestaurantUser.create(user: @admin, restaurant: @res, role: "owner")

    # restaurant owner logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end

    assert_content page, "Logged in"

    visit 
    refute_content page, "You're not authorized to do that!"
    assert_content page, "Manage Your Restaurant"

  end
end
