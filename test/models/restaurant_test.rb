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

end
