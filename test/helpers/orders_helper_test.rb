require 'test_helper'

class OrdersHelperTest < ActionView::TestCase
  test "the total is calculated correctly for one order item with one item" do
    order_item = OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 1)
    @order = Order.create(:id => 50)
    price = 5
    assert_equal price, order_total(@order.order_items)
  end

  test "the total is calculated correctly for one order item with two items" do
    order_item = OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 2)
    @order = Order.create(:id => 50)
    price = 10
    assert_equal price, order_total(@order.order_items)
  end

  test "the total is calculated correctly for one order item with a lot of items" do
    order_item = OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 5)
    @order = Order.create(:id => 50)
    price = 25
    assert_equal price, order_total(@order.order_items)
  end

  test "the total is calculated correctly for many order items with a lot of items" do
    order_item1 = OrderItem.create(:order_id => 50, :item_id => 1, :quantity => 5)
    order_item2 = OrderItem.create(:order_id => 50, :item_id => 3, :quantity => 5)
    order_item3 = OrderItem.create(:order_id => 50, :item_id => 2, :quantity => 5)
    @order = Order.create(:id => 50)
    price = 65
    assert_equal price, order_total(@order.order_items)
  end
end
