require "test_helper"

class HomeViewTest < Capybara::Rails::TestCase

  test "visit restaurant from home page" do
    visit root_path
    assert page.has_content?('Welcome to Noshify!')
    click_on "Denver"
    click_on "KFC"

    assert_equal restaurant_root_path(restaurants(:one)), current_path
    assert page.has_content?("Mashed Potatoes")
  end
end
