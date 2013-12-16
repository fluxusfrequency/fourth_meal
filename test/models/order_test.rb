require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "it is created with valid attributes" do
    assert orders(:one).valid?
  end

  test "it_validates_status" do
    order = Order.create()
    assert order.invalid?
  end

  test "it_validates_restaurant_id" do
    order = Order.new(status: "paid", restaurant_id: 1)
    assert order.valid?
    order.update(:restaurant_id => nil)
    refute order.valid?
  end

  test "it_validates_correct_type_of_status" do
    order = orders(:one)
    order.update(:status => 'mumbojumbo')
    refute order.valid?
  end

  test "it has items" do
    assert_equal items(:one), orders(:one).items.last
  end

  test "it has a user" do
    assert_equal users(:one), orders(:one).user
  end

  test "it has a restaurant" do
    assert_equal restaurants(:one), orders(:one).restaurant
  end

end
