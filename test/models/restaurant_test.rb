require "test_helper"

class RestaurantTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert restaurants(:one).valid?
  end

  test "it validates the presence of name" do
    restaurant = restaurants(:one)
    restaurant.update(name: nil)
    refute restaurant.valid?
  end

  test "it validates the presence of description" do
    restaurant = restaurants(:one)
    restaurant.update(description: nil)
    refute restaurant.valid?
  end

  test "it validates status is pending, rejected, or approved" do
    restaurant = restaurants(:one)
    assert restaurant.valid?
    restaurant.update(:status => "rejected")
    assert restaurant.valid?
    restaurant.update_attributes(:status => "pending")
    assert restaurant.valid?
    restaurant.update_attributes(:status => "Nebuchadnezzar")
    refute restaurant.valid?
  end

  test "it has categories" do
    assert_includes restaurants(:one).categories, categories(:one)
  end

  test "it has items" do
    assert_includes restaurants(:one).items, items(:one)
  end

  test "it has orders" do
    assert_includes restaurants(:one).orders, orders(:one)
  end

  test "it has restaurant users" do
    assert_includes restaurants(:one).restaurant_users, restaurant_users(:one)
  end

  test "it has a location" do
    assert_equal restaurants(:one).location, locations(:one)
  end

  test "the theme is in the set of acceptable themes" do
    restaurant = restaurants(:one)
    assert_equal "application", restaurant.theme
    restaurant.update(theme: "dark")
    assert_equal "dark", restaurant.theme
    restaurant.update(theme: "naranja")
    refute restaurant.valid?
  end

  test "it can generate its slug" do
    refute_equal "long-john-silvers", restaurants(:six).name
    refute_equal "long-john-silver-s", restaurants(:six).slug
    restaurants(:six).generate_slug
    assert_equal "long-john-silver-s", restaurants(:six).slug
  end

  test "it can find one of its owners" do
    assert_equal "bird", restaurants(:three).find_owner.display_name
  end

  test "it can activate, deactivate, and toggle itself" do
    refute restaurants(:four).active?
    restaurants(:four).activate
    assert restaurants(:four).active?
    restaurants(:four).deactivate
    refute restaurants(:four).active?
    restaurants(:four).toggle_status
    assert restaurants(:four).active?
    restaurants(:four).toggle_status
    refute restaurants(:four).active?
  end

  test "it knows if it is pending" do
    assert restaurants(:three).pending?
  end

end
