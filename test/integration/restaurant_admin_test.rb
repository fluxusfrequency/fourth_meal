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

    # Admin edits an item
    within "#the-whopper-row" do
      click_on "edit"
    end

    assert_content page, "Edit Menu Item"
    within ".edit_item" do
      fill_in "Title", with: "The Whopper Deluxe"
      fill_in "Description", with: "Beats a Whopper"
      fill_in "Price", with: 8
      click_on "Update Item"
    end
    assert_content page, "The Whopper Deluxe was updated!"

    # Admin toggles an item
    within "#the-whopper-deluxe-row" do
      assert_content "true"
      click_on "toggle"
    end
    assert_content page, "The Whopper Deluxe was retired from the menu!"

    within "#the-whopper-deluxe-row" do
      assert_content "false"
      click_on "toggle"
    end
    assert_content page, "The Whopper Deluxe was added to the menu!"

    # Admin logs out and is redirected to the home page
    click_on "Log out"
    assert_equal root_path, page.current_path
    @admin.destroy
    @ru.destroy
  end

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
    assert_content page, "Sorry, we couldn't find the restaurant you requested in our system."
  end


  def test_approved_restaurant_can_not_be_seen_when_unless_its_active
    visit root_path
    visit restaurant_root_path(restaurants(:seven))
    assert_content page, "Sorry, this restaurant is currently offline for maintenance."
  end

  def test_approved_restaurant_redirects_restaurant_owner_to_restaurant_admin_page

    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @ru = RestaurantUser.create(user: @admin, restaurant: restaurants(:seven), role: "owner")

    # restaurant owner logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end

    assert_equal "approved", restaurants(:seven).status

    assert_content page, "Logged in"

    assert_equal "jeffs-lab", restaurants(:seven).slug

    visit restaurant_root_path(restaurants(:seven).slug)
    assert_equal admin_path(restaurants(:seven)), current_path
    assert_content page, "Manage Your Restaurant"
  end

  def test_pending_restaurant_cannot_be_activated_by_restaurant_owner
    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @ru = RestaurantUser.create(user: @admin, restaurant: restaurants(:four), role: "owner")
    visit restaurant_root_path(restaurants(:seven))
    assert_content page, "Sorry, this restaurant is currently offline for maintenance."
  end

  def test_owner_can_activate_approved_restaurant

    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @ru = RestaurantUser.create(user: @admin, restaurant: restaurants(:seven), role: "owner")

    # restaurant owner logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end

    assert_content page, "Logged in"
    visit admin_path(restaurants(:seven))
    refute_content page, "You're not authorized to do that!"
    assert_content page, "Manage Your Restaurant"

    assert_content page, "Offline"
    click_on "Activate"
    assert_content page, "Active"
  end

  def test_pending_restaurant_cannot_be_activated_by_restaurant_owner
    @admin = User.create(full_name: "Joan of Arc", display_name: "Joan A.", email: 'jarc@thestake.fr', password: 'martyr', password_confirmation: 'martyr')
    @ru = RestaurantUser.create(user: @admin, restaurant: restaurants(:four), role: "owner")

    #make sure restaurant is pending
    assert_equal "pending", restaurants(:four).status

    # restaurant owner logs in
    visit root_path
    click_on "Sign up or Log in"
    within "#login-form" do
      fill_in "Email", with: 'jarc@thestake.fr'
      fill_in "Password", with: 'martyr'
      click_button "Log In"
    end

    assert_content page, "Logged in"

    visit admin_path(restaurants(:four))
    refute_content page, "Manage Your Restaurant"
    assert_equal root_path, current_path

  end


end

