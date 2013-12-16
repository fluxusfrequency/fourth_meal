require './test/test_helper'

class SupermanTest < Capybara::Rails::TestCase

  def test_superman_views_the_admin_panel
    @superman = User.create(full_name: "Clark Kent", display_name: "Superman", email: 'ckent@dailyplanet.com', password: 'kryptonite', password_confirmation: 'kryptonite', :super => true)
    # Superman page is unavailable to guests
    visit superman_path
    assert_content page, "You must be logged in to do that!"
    # Superman logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'ckent@dailyplanet.com'
      fill_in "Password", with: 'kryptonite'
      click_button "Log In"
    end
    assert_content page, "Logged in"
    assert_content page, "Superman Panel"
    visit superman_path
    refute_content page, "You're not authorized to do that!"
    assert_content page, "All Restaurants In The System"
    assert_content page, "Approve"
    assert_content page, "Reject"
    assert_content page, "Administer"

    # Superman logs out and is redirected to the home page
    click_on "Log out"
    assert_equal root_path, page.current_path
    @superman.destroy
  end

  def test_superman_views_approves_and_rejects_pending_restaurants
    @superman = User.create(full_name: "Clark Kent", display_name: "Superman", email: 'ckent@dailyplanet.com', password: 'kryptonite', password_confirmation: 'kryptonite', :super => true)
    # Can't view a pending restaurant
    visit restaurant_root_path(restaurants(:three).id)
    assert_equal root_path, page.current_path
    assert_content page, "Sorry, this restaurant is currently offline for maintenance."

    # Superman logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'ckent@dailyplanet.com'
      fill_in "Password", with: 'kryptonite'
      click_button "Log In"
    end

    # Superman views all restaurants
    visit superman_path
    within "#taco-bell_row" do
      refute_content page, "approved"
    end

    # Superman views pending restaurants
    click_on "Pending Approval"
    assert_content page, "Pending Restaurants"

    # Superman approves a restaurant
    within "#taco-bell_row" do
      assert_content page, "Taco Bell"
      assert_content page, "pending"
      find("#approve_button").click
    end
    
    assert_content page, "Taco Bell was approved!"
    within "#taco-bell_row" do
      assert_content page, "approved"
    end

    # Superman views rejected restaurants
    click_on "Rejected"
    assert_content page, "Rejected Restaurants"
    refute_content page, "Pizza Hut"

    # Superman views pending restaurants
    click_on "Pending Approval"
    assert_content page, "Pending Restaurants"

    # Superman rejects a restaurant
    within "#pizza-hut_row" do
      assert_content page, "Pizza Hut"
      assert_content page, "pending"
      find("#reject_button").click
    end

    # Superman is redirected to the restaurant listing and no longer sees Pizza Hut
    assert_content page, "Pizza Hut was rejected!"
    refute page.has_css?("#pizza-hut_row")

    #Superman views rejected restaurants to confirm restaurant shows up there
    click_on "Rejected"
    assert_content page, "Rejected Restaurants"
    within "#pizza-hut_row" do
      assert_content page, "rejected"
    end

    # Superman logs out
    click_on "Log out"
    @superman.destroy
  end

  def test_superwoman_administers_a_restaurant
    @superwoman = User.create(full_name: "Lois Lane", display_name: "Superwoman", email: 'llane@aol.com', password: 'password', password_confirmation: 'password', :super => true)
    # Superwoman logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'llane@aol.com'
      fill_in "Password", with: 'password'
      click_button "Log In"
    end
    assert_content page, "Logged in"

    # Superwoman administers McDonalds
    visit superman_path
    within "#mcdonalds_row" do
      click_on "administer"
    end
    assert_content page, "Manage Your Restaurant"
    assert_content page, "Edit Restaurant Details"

    # Superwoman changes McDonalds to Burger King
    within ".edit_restaurant" do
      fill_in "Name", with: "Burger King"
      fill_in "Description", with: "Flame Broiled, Dawg!"
      click_button "Save Restaurant"
    end
    assert_content page, "Burger King was updated!"
    assert_content page, "Flame Broiled, Dawg!"

    # Superwoman adds an item
    click_on "Create New Item"
    assert_content page, "Create New Menu Item"

    within "#new_item" do
      fill_in "Title", with: "The Whopper"
      fill_in "Description", with: "Beats a big mac"
      fill_in "Price", with: 6
      click_on "Create Item"
    end
    assert_content page, "The Whopper was added to the menu!"

    # Superwoman retires an item
    within "#the-whopper-row" do
      click_on "retire"
    end
    assert_content page, "The Whopper was retired from the menu!"

    # Superwoman logs out
    click_on "Log out"
    @superwoman.destroy
  end

end

