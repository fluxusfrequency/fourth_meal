require "test_helper"

class UsersTest < ActiveSupport::TestCase

  def create_valid_user
    @user = User.create(email:"teeest@example.com", display_name:"benjammin", full_name:"Benjamin B Lewis, esq.", password:"password", password_confirmation: "password")
  end

  def setup
    create_valid_user
  end

  test "it is valid with valid attributes" do
    assert @user.valid?
  end

  test "it validates email" do
    @user.update(email: nil)
    refute @user.valid?
  end

 
  test "it_validates_full_name" do
    @user.update(full_name: nil)
    refute @user.valid?
  end

  test "it_validates_display_name" do 
    @user.update(display_name: nil)
    refute @user.valid?
  end 

  test "it_is_not_a_super_by_default" do 
    refute @user.super
    @user.update(super: true)
    assert @user.super
  end 

  test "it can have one or more orders" do
    order = orders(:one)
    order.update(user: @user)
    order2 = orders(:two)
    order2.update(user: @user)

    assert @user.orders.count == 2
  end

  test "it can have one or more addresses" do
    address = addresses(:one)
    address.update(user_id: @user.id)
    address2 = addresses(:two)
    address2.update(user_id: @user.id)

    assert @user.addresses.count == 2
  end

  test "it has restaurant users" do 
    assert_includes users(:one).restaurant_users, restaurant_users(:one)
  end

  test "it can turn into superman" do 
    user = users(:two)
    refute user.superman?
    user.supercharge
    assert user.superman?
  end

end
