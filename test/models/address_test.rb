require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "it is invalid without attributes" do
    address = Address.create()
    refute address.valid?
  end

  test "it is valid with correct attributes" do
    assert addresses(:one).valid?
  end

  test "it does not create am address when first name is empty" do
    address = addresses(:one)
    address.update(first_name: nil)
    refute address.valid?
  end

  test "it does not create an address when last name is empty" do
    address = addresses(:one)
    address.update(last_name: nil)
    refute address.valid?
  end


  test "it does not create a address when street_address is invalid" do
    address = addresses(:one)
    address.update(street_address: nil)
    refute address.valid?
  end

  test "it does not create a address when city is invalid" do
    address = addresses(:one)
    address.update(city: nil)
    refute address.valid?
  end

  test "it does not create a address when state is invalid" do
    address = addresses(:one)
    address.update(state: "AAZ")
    refute address.valid?
  end

  test "it does not create a address when zipcode is invalid" do
    address = addresses(:one)
    address.update(zipcode: 129444)
    refute address.valid?
  end

  test "it validates email" do
    address = addresses(:one)
    address.update(email: nil)
    refute address.valid?
  end

  test "it can optionally be associated with a user" do
    address = addresses(:two)
    address.update(user_id: nil)
    assert address.valid?
    address.update(user_id: users(:one).id)
    assert address.valid?
    assert_equal users(:one), address.user
  end

end
