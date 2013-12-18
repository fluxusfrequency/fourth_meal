require './test/test_helper'

class TransactionTest < ActiveSupport::TestCase

  test "it is invalid without attributes" do
    transaction = Transaction.create()
    refute transaction.valid?
  end

  test "it is valid with correct attributes" do
    assert transactions(:one).valid?
  end

  test "it validates order id" do
    transactions(:one).update(order_id: nil)
    refute transactions(:one).valid?
  end

  test "it can pay its order" do
    assert_equal 'unpaid', transactions(:one).order.status
    transactions(:one).pay!
    assert_equal 'paid', transactions(:one).order.status
  end

  test "it knows its total" do
    total = transactions(:one).order.total_price
    assert_equal total, transactions(:one).total
  end

  test "it has an address" do
    assert_equal addresses(:two), transactions(:two).address
  end

end
