require './test/test_helper'


class CanMakeAnOrderTest < Capybara::Rails::TestCase

  test "a user can create an order" do
    visit root_path
    click_on "Denver"
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"

  end

  test "can add multiple items to order without logging in" do
    visit root_path
    click_on "Denver"
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    within "#item_#{items(:three).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    assert_content page, "Chicken Drumsticks"
  end

  test "can add multiple instances of same item to order" do
    visit root_path
    click_on "Denver"
    click_on "KFC"

    within "#item_#{items(:one).id}" do
      click_on "Add to Cart"
    end

    within "#item_#{items(:one).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"
    within("#current_order") do
      assert_content page, "2"
    end
  end

  test "a user can create an order on multiple stores" do
    visit root_path
    click_on "Denver"
    click_on "KFC"

    within "#item_#{items(:two).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    assert_content page, 'Your Current Order'
    assert_content page, "Mashed Potatoes"

    visit root_path
    click_on "Washington D.C."
    click_on "McDonalds"

    within "#item_#{items(:four).id}" do
      click_on "Add to Cart"
    end

    click_on "View Your Order"
    assert_content page, 'Your Current Order'
    refute_content page, "Mashed Potatoes"
    assert_content page, "Big Mac"

    
  end

end
