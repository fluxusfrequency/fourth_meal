require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  test "the total is calculated correctly for one order item with one item" do
    OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 1)
    @order = Order.create(:id => 50)
    price = 5.99
    assert_equal price, order_total(@order.order_items).to_f
  end

  test "the total is calculated correctly for one order item with two items" do
    OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 2)
    @order = Order.create(:id => 50)
    price = (5.99 * 2)
    assert_equal price, order_total(@order.order_items).to_f
  end

  test "the total is calculated correctly for one order item with a lot of items" do
    OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 5)
    @order = Order.create(:id => 50)
    price = 29.95
    assert_equal price, order_total(@order.order_items).to_f
  end

  test "the total is calculated correctly for many order items with a lot of items" do
    OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 5)
    OrderItem.create(:order_id => 50, :item_id => 3, :quantity => 5)
    OrderItem.create(:order_id => 50, :item_id => 2, :quantity => 5)
    @order = Order.create(:id => 50)
    price = 79.85
    assert_equal price, order_total(@order.order_items).to_f
  end

  test "items in carts does not fail" do
    skip
    @order = Order.create(:id => 50)
    # items_in_cart?
  end
end
