module OrdersHelper

  def order_total(order_items)
    order_items.inject(0) do |sum, order_item|
      sum += (order_item.item.price * order_item.quantity)
    end
  end

  def items_in_cart?
    current_order && current_order.order_items.count > 0
  end

end
