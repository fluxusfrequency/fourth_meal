require "test_helper"

class BrandingTest < Capybara::Rails::TestCase

  test "visit different restaurants and see different branding and items" do
    create_valid_restaurant

    visit root_path
    assert page.has_content?('All Restaurants')
    click_on "KFC"

    assert_equal restaurant_root_path(@restaurant), current_path

    within '#restaurant-title' do
        assert page.has_content?("KFC")
    end

    assert page.has_content?("Mashed Potatoes")


    create_another_valid_restaurant
    visit root_path
    click_on "McDonalds"
    assert_equal restaurant_root_path(@new_restaurant), current_path
    within '#restaurant-title' do
        assert page.has_content?("McDonalds")
    end
    assert page.has_content?("Big Mac")
    refute page.has_content?("Mashed Potatoes")

  end
end
