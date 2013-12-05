require "test_helper"

class HomeViewTest < Capybara::Rails::TestCase

  test "visit restaurant from home page" do
    create_valid_restaurant

    visit root_path
    assert page.has_content?('All Restaurants')
    click_on "KFC"

    assert_equal restaurant_root_path(@restaurant), current_path
    assert page.has_content?("Mashed Potatoes")
  end
end
