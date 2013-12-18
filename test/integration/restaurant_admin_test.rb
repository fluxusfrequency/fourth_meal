require './test/test_helper'

class RestaurantAdminTest < Capybara::Rails::TestCase

  def test_admin_views_the_admin_panel
    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @ru = RestaurantUser.create(user: @admin, restaurant: restaurants(:one), role: "owner")

    # Admin page is unavailable to guests
    visit admin_path(restaurants(:one))
    assert_content page, "You must be logged in to do that!"

    # Admin logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end
    assert_content page, "Logged in"
    visit restaurant_root_path(restaurants(:one))
    refute_content page, "You're not authorized to do that!"

    visit admin_path(restaurants(:one))

    # Admin changes McDonalds to Burger King
    within ".edit_restaurant" do
      fill_in "Name", with: "Burger King"
      fill_in "Description", with: "Flame Broiled, Dawg!"
      click_button "Save Restaurant"
    end
    assert_content page, "Burger King was updated!"
    assert_content page, "Flame Broiled, Dawg!"

    # Admin adds an item
    click_on "Create A New Item"
    assert_content page, "Create New Menu Item"

    within "#new_item" do
      fill_in "Title", with: "The Whopper"
      fill_in "Description", with: "Beats a big mac"
      fill_in "Price", with: 6
      click_on "Create Item"
    end
    assert_content page, "The Whopper was added to the menu!"

    # Admin retires an item
    within "#the-whopper-row" do
      click_on "toggle"
    end
    assert_content page, "The Whopper was retired from the menu!"

    # Admin logs out and is redirected to the home page
    click_on "Log out"
    assert_equal root_path, page.current_path
    @admin.destroy
    @ru.destroy
  end

end

