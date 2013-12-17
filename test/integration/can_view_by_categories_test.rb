require './test/test_helper'

class CanViewByCategoriesTest < Capybara::Rails::TestCase

  test "can see only items in selected category" do
    visit root_path
    click_on "KFC"
    click_on "Brunch"
    assert_content page, "Hello!"
    refute_content page, "Chicken Drumsticks"
  end

end
